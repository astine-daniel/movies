struct UpcomingMoviesAPIService {
    // MARK: - Properties
    private let apiService: APIServiceProtocol

    // MARK: - Initialization
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
}

// MARK: - UpcomingMoviesAPIServiceProtocol extension
extension UpcomingMoviesAPIService: UpcomingMoviesAPIServiceProtocol {
    func upcomingMovies(at page: Int, _ completion: @escaping Completion<ResponseModel.UpcomingMovies>) {
        apiService.request(resource: .upcoming(), completion)
    }
}

// MARK: - Private extension
private extension APIServiceProtocol {
    @discardableResult
    func request(
        resource: UpcomingMoviesResource,
        _ completion: @escaping Completion<ResponseModel.UpcomingMovies>) -> Request? {
        return request(resource, completion)
    }
}
