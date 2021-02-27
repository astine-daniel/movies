import Foundation

struct GenresRepository {
    // Properties
    private static var genres: [ResponseModel.Genre] = []

    private let service: GenresAPIServiceProtocol

    // MARK: - Initialization
    init(service: GenresAPIServiceProtocol = GenresAPIService()) {
        self.service = service
    }
}

// MARK: - GenresRepositoryProtocol extension
extension GenresRepository: GenresRepositoryProtocol {
    func genres(_ completion: @escaping Completion<GenresSearchable>) {
        guard GenresRepository.genres.isEmpty else {
            completion(.success(self))
            return
        }

        service.genres { result in
            switch result {
            case let .success(genres):
                GenresRepository.genres = genres.genres
                completion(.success(self))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - GenresSearchable extension
extension GenresRepository: GenresSearchable {
    var all: [String] { GenresRepository.genres.map { $0.name } }

    func with(ids: [Int]) -> [String] {
        find(GenresRepository.genres, with: ids)
    }
}

// MARK: - Private extension
private extension GenresRepository {
    func find(_ genres: [ResponseModel.Genre], with ids: [Int]) -> [String] {
        genres
            .filter { ids.contains($0.id) }
            .sorted { $0.id > $1.id }
            .map { $0.name }
    }
}
