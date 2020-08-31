protocol ConfigurationAPIServiceProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func configuration(_ completion: @escaping Completion<ResponseModel.Configuration>)
}
