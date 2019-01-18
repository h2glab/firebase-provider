import Foundation
import HTTP
import Vapor

/// The maximum streaming body size to allow.
/// This only applies to streaming bodies, like chunked streams.
private let maxStreamingBodySize: Int = 1_000_000

public protocol FirebaseRequest: class {
    func validateResponse<FM: FirebaseModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<FM>
    func send<FM: FirebaseModel>(method: HTTPMethod, url: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<FM>
}

public extension FirebaseRequest {

    public func validateResponse<FM: FirebaseModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<FM> {
        let decoder = JSONDecoder()

        guard response.status == .ok else {
            return try decoder.decode(FirebaseError.self, from: response, maxSize: maxStreamingBodySize, on: worker).map(to: FM.self) { error in
                throw error
            }
        }

        return try decoder.decode(FM.self, from: response, maxSize: maxStreamingBodySize, on: worker)
    }
}

extension HTTPHeaders {
    public static var firebaseDefault: HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
        return headers
    }
}

public class FirebaseAPIRequest: FirebaseRequest {
    private let httpClient: Client
    private let apiKey: String

    init(httpClient: Client, apiKey: String) {
        self.httpClient = httpClient
        self.apiKey = apiKey
    }

    public func send<FM: FirebaseModel>(method: HTTPMethod, url: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<FM> {
        var finalHeaders: HTTPHeaders = .firebaseDefault
        headers.forEach {
            finalHeaders.replaceOrAdd(name: $0.name, value: $0.value)
        }
        
        let fullUrl = formatUrl(url, with: query)
        return httpClient.send(method, headers: finalHeaders, to: fullUrl) { (request: Request) in
            return request.http.body = body.convertToHTTPBody()
        }.flatMap(to: FM.self) { (response) -> Future<FM> in
            return try self.validateResponse(response: response.http, worker: self.httpClient.container.eventLoop)
        }
    }
    
    fileprivate func formatUrl(_ url: String, with query: String) -> String {
        if query.isEmpty {
            return "\(url)?key=\(apiKey)"
        } else {
            return "\(url)?\(query)&key=\(apiKey)"
        }
    }
}
