import Foundation

struct GenresRepository {
    // Properties
    private let service: GenresAPIServiceProtocol

    private static var genres: ResponseModel.Genres?

    // MARK: - Initialization
    init(service: GenresAPIServiceProtocol = GenresAPIService()) {
        self.service = service
    }
}

// MARK: - GenresRepositoryProtocol extension
extension GenresRepository: GenresRepositoryProtocol {
    func genres(with ids: [Int], _ completion: @escaping Completion<[String]>) {
        if let genres = GenresRepository.genres {
            let genres = find(genres.genres, with: ids)
            completion(.success(genres))

            return
        }

        service.genres { result in
            switch result {
            case let .success(genres):
                GenresRepository.genres = genres
                let genres = self.find(genres.genres, with: ids)

                completion(.success(genres))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private extension
private extension GenresRepository {
    func find(_ genres: [ResponseModel.Genre], with ids: [Int]) -> [String] {
        return genres
            .filter { ids.contains($0.id) }
            .map { $0.name }
    }
}
