import Vapor

class ClientStub: Client {
    
    var container: Container
    let responseText: String
    let error: String?
    let httpStatus: HTTPStatus

    var calls: [HttpCall] = []
    
    init(responseText: String) {
        self.responseText = responseText
        self.container = ContainerStub()
        self.error = nil
        self.httpStatus = .ok
    }
    
    init(withError error: String, withStatus httpStatus: HTTPStatus) {
        self.responseText = ""
        self.container = ContainerStub()
        self.error = error
        self.httpStatus = httpStatus
    }
    
    func send(_ req: Request) -> EventLoopFuture<Response> {
        calls.append(HttpCall(request: req))
        if let error = self.error {
            return self.container.future().map(to: Response.self) {
                let httpBody = HTTPBody(string: error)
                var httpHeaders = HTTPHeaders()
                httpHeaders.add(name: HTTPHeaderName.contentType, value: MediaType.json.description)
                return Response(http: HTTPResponse(status: self.httpStatus, headers: httpHeaders, body: httpBody), using: self.container)
            }
        }
        return self.container.future().map(to: Response.self) {
            let httpBody = HTTPBody(string: self.responseText)
            var httpHeaders = HTTPHeaders()
            httpHeaders.add(name: HTTPHeaderName.contentType, value: MediaType.json.description)
            return Response(http: HTTPResponse(status: self.httpStatus, headers: httpHeaders, body: httpBody), using: self.container)
        }
    }
    
    func reset() {
        self.calls.removeAll()
    }
}


struct HttpCall {
    var method: HTTPMethod
    var url: URL
    var body: LosslessHTTPBodyRepresentable
    var headers: HTTPHeaders
}

extension HttpCall {

    init(request: Request) {
        let httpRequest = request.http
        self.method = httpRequest.method
        self.url = httpRequest.url
        self.body = httpRequest.body
        self.headers = httpRequest.headers
    }
}
