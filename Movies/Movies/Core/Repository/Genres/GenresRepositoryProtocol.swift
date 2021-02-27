protocol GenresSearchable {
    var all: [String] { get }

    func with(ids: [Int]) -> [String]
}

protocol GenresRepositoryProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func genres(_ completion: @escaping Completion<GenresSearchable>)
}
