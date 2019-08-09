protocol MoviesRepositoryProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    func fetchUpcomingMovies(_ completion: @escaping Completion<[Model.Movie]>)
    func fetchMoreUpcomingMovies(_ completion: @escaping Completion<[Model.Movie]>)
}
