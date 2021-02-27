import struct Foundation.URLQueryItem

struct APIServiceInfo {
    let environment: Environment

    init(environment: Environment = .current) {
        self.environment = environment
    }
}

extension APIServiceInfo {
    static var `default`: APIServiceInfo { APIServiceInfo() }
}

extension APIServiceInfo: APIServiceInfoProtocol {
    var baseURL: URLConvertible { "https://api.themoviedb.org" }
    var version: String { "3" }
    var apiKey: String { Credentials.apiKey }
}

extension URLQueryItem {
    static func apiKey(value: String) -> URLQueryItem { URLQueryItem(name: "api_key", value: value) }
}
