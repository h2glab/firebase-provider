import Vapor

class ClientStub: Client {
    
    var container: Container
    let responseText: String
    let error: Error?

    var calls: [HttpCall] = []
    
    init(responseText: String) {
        self.responseText = responseText
        self.container = ContainerStub()
        self.error = nil
    }
    
    init(withError error: Error) {
        self.responseText = ""
        self.container = ContainerStub()
        self.error = error
    }
    
    func send(_ req: Request) -> EventLoopFuture<Response> {
        calls.append(HttpCall(request: req))
        if let error = self.error {
            return self.container.future(error: error)
        }
        return self.container.future().map(to: Response.self) {
            let httpBody = HTTPBody(string: self.responseText)
            var httpHeaders = HTTPHeaders()
            httpHeaders.add(name: HTTPHeaderName.contentType, value: MediaType.json.description)
            return Response(http: HTTPResponse(headers: httpHeaders, body: httpBody), using: self.container)
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
