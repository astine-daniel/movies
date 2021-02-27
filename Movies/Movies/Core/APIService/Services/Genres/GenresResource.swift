import Foundation

struct GenresResource {
    // MARK: - Properties
    private (set) var baseURL: URLConvertible
    private (set) var version: String?
    private (set) var method: HTTPMethod
    private (set) var endpoint: Endpoint
    private (set) var parser: ResourceParser
}

// MARK: - Resource extension
extension GenresResource: Resource { }

// MARK: - Methods
extension GenresResource {
    static func genres(info: APIServiceInfoProtocol = APIServiceInfo.default) -> GenresResource {
        let queryItems: [URLQueryItem] = [.apiKey(value: info.apiKey)]
        let endpoint = Endpoint(path: "genre/movie/list", queryItems: queryItems)

        let parser = ClosureResourceParser(GenresResource.parser)

        return GenresResource(
            baseURL: info.baseURL,
            version: info.version,
            endpoint: endpoint,
            parser: parser
        )
    }
}

// MARK: - Private extension
private extension GenresResource {
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

    static func parser(data: Data?) throws -> ResponseModel.Genres {
        guard let data = data else { return ResponseModel.Genres(genres: [ResponseModel.Genre]()) }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(ResponseModel.Genres.self, from: data)
    }
}
