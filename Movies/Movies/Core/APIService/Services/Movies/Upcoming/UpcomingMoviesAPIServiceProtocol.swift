protocol UpcomingMoviesAPIServiceProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func upcomingMovies(at page: Int, _ completion: @escaping Completion<ResponseModel.UpcomingMovies>)
}

extension UpcomingMoviesAPIServiceProtocol {
    func upcomingMovies(_ completion: @escaping Completion<ResponseModel.UpcomingMovies>) {
        upcomingMovies(at: 1, completion)
    }
}
