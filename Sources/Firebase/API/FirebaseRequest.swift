import Foundation
import HTTP
import Vapor

public protocol FirebaseRequest: class {
    func serializedResponse<FM: FirebaseModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<FM>
    func send<FM: FirebaseModel>(method: HTTPMethod, url: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<FM>
}

public extension FirebaseRequest {

    public func serializedResponse<FM: FirebaseModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<FM> {
        let decoder = JSONDecoder()

        guard response.status == .ok else {
            return try decoder.decode(FirebaseError.self, from: response, maxSize: 65_536, on: worker)
                .map(to: FM.self) { error in throw error }
                .catchMap { error in
                    if let error = error as? FirebaseError {
                        throw error
                    }
                    throw FirebaseError(error: error) }
        }

        return try decoder.decode(FM.self, from: response, maxSize: 65_536, on: worker)
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
            return try self.serializedResponse(response: response.http, worker: self.httpClient.container.eventLoop)
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
