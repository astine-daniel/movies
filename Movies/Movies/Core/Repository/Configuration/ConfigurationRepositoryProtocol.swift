protocol ConfigurationRepositoryProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func configuration(_ completion: @escaping Completion<Model.Configuration>)
}
