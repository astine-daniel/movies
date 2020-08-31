import Foundation

struct UpcomingMoviesResource {
    // MARK: - Properties
    private (set) var baseURL: URLConvertible
    private (set) var version: String?
    private (set) var method: HTTPMethod
    private (set) var endpoint: Endpoint
    private (set) var parser: ResourceParser
}

// MARK: - Resource extension
extension UpcomingMoviesResource: Resource { }

// MARK: - Methods
extension UpcomingMoviesResource {
    static func upcoming(
        page: Int = 1,
        info: APIServiceInfoProtocol = APIServiceInfo.default) -> UpcomingMoviesResource {
        let queryItems: [URLQueryItem] = [
            .apiKey(value: info.apiKey),
            URLQueryItem(name: "page", value: String(page))
        ]

        let endpoint = Endpoint(path: "movie/upcoming",
                                queryItems: queryItems)

        let parser = ClosureResourceParser(UpcomingMoviesResource.parser)

        return UpcomingMoviesResource(baseURL: info.baseURL,
                                      version: info.version,
                                      endpoint: endpoint,
                                      parser: parser)
    }
}

// MARK: - Private extension
private extension UpcomingMoviesResource {
    // MARK: - Initialization
    init(baseURL: URLConvertible,
         version: String? = nil,
         endpoint: Endpoint,
         method: HTTPMethod = .get,
         parser: ResourceParser) {
        self.baseURL = baseURL
        self.version = version
        self.endpoint = endpoint
        self.method = method
        self.parser = parser
    }

    static func parser(data: Data?) throws -> ResponseModel.UpcomingMovies {
        guard let data = data else {
            return ResponseModel.UpcomingMovies(page: 1, totalPages: 1, movies: [])
        }

        let decoder = JSONDecoder()
        return try decoder.decode(ResponseModel.UpcomingMovies.self, from: data)
    }
}
