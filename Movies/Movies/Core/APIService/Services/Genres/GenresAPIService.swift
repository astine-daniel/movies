struct GenresAPIService {
    // MARK: - Properties
    private let apiService: APIServiceProtocol

    // MARK: - Initialization
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
}

// MARK: - ConfigurationAPIServiceProtocol extension
extension GenresAPIService: GenresAPIServiceProtocol {
    func genres(_ completion: @escaping Completion<ResponseModel.Genres>) {
        apiService.request(resource: .genres(), completion)
    }
}

// MARK: - Private extension
private extension APIServiceProtocol {
    @discardableResult
    func request(
        resource: GenresResource,
        _ completion: @escaping Completion<ResponseModel.Genres>) -> Request? {
        return request(resource, completion)
    }
}
