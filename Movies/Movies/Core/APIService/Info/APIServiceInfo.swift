import struct Foundation.URLQueryItem

struct APIServiceInfo {
    let environment: Environment

    init(environment: Environment = .current) {
        self.environment = environment
    }
}

extension APIServiceInfo {
    static var `default`: APIServiceInfo { return APIServiceInfo() }
}

extension APIServiceInfo: APIServiceInfoProtocol {
    var baseURL: URLConvertible { return "https://api.themoviedb.org" }
    var version: String { return "3" }
    var apiKey: String { return Credentials.apiKey }
}

extension URLQueryItem {
    static func apiKey(value: String) -> URLQueryItem {
        return URLQueryItem(name: "api_key", value: value)
    }
}
