protocol GenresRepositoryProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func genres(with ids: [Int], _ completion: @escaping Completion<[String]>)
}
