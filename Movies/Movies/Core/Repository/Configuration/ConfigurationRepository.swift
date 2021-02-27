import Foundation

struct ConfigurationRepository {
    // Properties
    private static var configuration: Model.Configuration?

    private let service: ConfigurationAPIServiceProtocol

    // MARK: - Initialization
    init(service: ConfigurationAPIServiceProtocol = ConfigurationAPIService()) {
        self.service = service
    }
}

// MARK: - ConfigurationRepositoryProtocol extension
extension ConfigurationRepository: ConfigurationRepositoryProtocol {
    func configuration(_ completion: @escaping Completion<Model.Configuration>) {
        if let configuration = ConfigurationRepository.configuration {
            completion(.success(configuration))
            return
        }

        service.configuration { result in
            switch result {
            case let .success(configuration):
                let configuration = self.transform(configuration)
                ConfigurationRepository.configuration = configuration

                completion(.success(configuration))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private extension
private extension ConfigurationRepository {
    func transform(_ response: ResponseModel.Configuration) -> Model.Configuration {
        let baseUrl = URL(string: response.images.secureBaseUrl)
        let backdropSize = response.images.backdropSizes.first { $0.contains("780") } ?? "original"
        let posterSize = response.images.posterSizes.first { $0.contains("500") } ?? "original"

        return Model.Configuration(imageBaseUrl: baseUrl, backdropSize: backdropSize, posterSize: posterSize)
    }
}
