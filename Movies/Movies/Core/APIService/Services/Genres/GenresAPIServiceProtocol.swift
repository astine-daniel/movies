protocol GenresAPIServiceProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func genres(_ completion: @escaping Completion<ResponseModel.Genres>)
}
