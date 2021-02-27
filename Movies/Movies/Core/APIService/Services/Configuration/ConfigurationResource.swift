import Foundation

struct ConfigurationResource {
    // MARK: - Properties
    private (set) var baseURL: URLConvertible
    private (set) var version: String?
    private (set) var method: HTTPMethod
    private (set) var endpoint: Endpoint
    private (set) var parser: ResourceParser
}

// MARK: - Resource extension
extension ConfigurationResource: Resource { }

// MARK: - Methods
extension ConfigurationResource {
    static func configuration(info: APIServiceInfoProtocol = APIServiceInfo.default) -> ConfigurationResource {
        let queryItems: [URLQueryItem] = [.apiKey(value: info.apiKey)]
        let endpoint = Endpoint(path: "configuration", queryItems: queryItems)

        let parser = ClosureResourceParser(ConfigurationResource.parser)
        return ConfigurationResource(baseURL: info.baseURL, version: info.version, endpoint: endpoint, parser: parser)
    }
}

// MARK: - Private extension
private extension ConfigurationResource {
    // MARK: - Initialization
    // swiftlint:disable:next function_default_parameter_at_end
    init(
        baseURL: URLConvertible,
        version: String? = nil,
        endpoint: Endpoint,
        method: HTTPMethod = .get,
        parser: ResourceParser
    ) {
        self.baseURL = baseURL
        self.version = version
        self.endpoint = endpoint
        self.method = method
        self.parser = parser
    }

    static func parser(data: Data?) throws -> ResponseModel.Configuration {
        guard let data = data else { throw NetworkingError.parseFailed(type: ResponseModel.Configuration.self) }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(ResponseModel.Configuration.self, from: data)
    }
}
