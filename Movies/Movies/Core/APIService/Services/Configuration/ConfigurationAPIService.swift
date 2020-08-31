struct ConfigurationAPIService {
    // MARK: - Properties
    private let apiService: APIServiceProtocol

    // MARK: - Initialization
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
}

// MARK: - ConfigurationAPIServiceProtocol extension
extension ConfigurationAPIService: ConfigurationAPIServiceProtocol {
    func configuration(_ completion: @escaping Completion<ResponseModel.Configuration>) {
        apiService.request(resource: .configuration(), completion)
    }
}

// MARK: - Private extension
private extension APIServiceProtocol {
    @discardableResult
    func request(
        resource: ConfigurationResource,
        _ completion: @escaping Completion<ResponseModel.Configuration>) -> Request? {
        return request(resource, completion)
    }
}
