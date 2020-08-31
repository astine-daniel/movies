import Foundation

final class MoviesRepository {
    // Properties
    private let service: UpcomingMoviesAPIServiceProtocol

    private let configurationRepository: ConfigurationRepositoryProtocol
    private let genresRepository: GenresRepositoryProtocol

    private var currentPage: Int = 0

    // MARK: - Initialization
    init(service: UpcomingMoviesAPIServiceProtocol = UpcomingMoviesAPIService(),
         configurationRepository: ConfigurationRepositoryProtocol = ConfigurationRepository(),
         genresRepository: GenresRepositoryProtocol = GenresRepository()) {
        self.service = service
        self.configurationRepository = configurationRepository
        self.genresRepository = genresRepository
    }
}

// MARK: - MoviesRepositoryProtocol extension
extension MoviesRepository: MoviesRepositoryProtocol {
    func fetchUpcomingMovies(_ completion: @escaping Completion<[Model.Movie]>) {
        service.upcomingMovies { result in
            self.handleMovieResult(result: result, page: 1, completion: completion)
        }
    }

    func fetchMoreUpcomingMovies(_ completion: @escaping Completion<[Model.Movie]>) {
        let page = currentPage + 1
        service.upcomingMovies(at: page) { result in
            self.handleMovieResult(result: result, page: page, completion: completion)
        }
    }
}

// MARK: - Private extension
private extension MoviesRepository {
    // MARK: - Configuration
    func fetchConfiguration(
        _ movies: ResponseModel.UpcomingMovies,
        _ completion: @escaping Completion<[Model.Movie]>) {
        configurationRepository.configuration { result in
            switch result {
            case let .success(configuration):
                self.fetchGenres(movies, configuration: configuration, completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchGenres(
        _ movies: ResponseModel.UpcomingMovies,
        configuration: Model.Configuration,
        _ completion: @escaping Completion<[Model.Movie]>) {
        genresRepository.genres { result in
            switch result {
            case let .success(genresSearch):
                self.handle(movies: movies,
                            configuration: configuration,
                            genresSearch: genresSearch,
                            completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Helpers
    func handle(
        movies: ResponseModel.UpcomingMovies,
        configuration: Model.Configuration,
        genresSearch: GenresSearchable,
        completion: @escaping Completion<[Model.Movie]>) {
        let movies = movies.movies.map { transform($0, configuration: configuration, genresSearch: genresSearch) }
        completion(.success(movies))
    }

    func transform(
        _ response: ResponseModel.Movie,
        configuration: Model.Configuration,
        genresSearch: GenresSearchable) -> Model.Movie {
        let posterUrl = configuration.posterUrl(path: response.posterPath)
        let backdropUrl = configuration.backdropUrl(path: response.backdropPath)
        let genres = genresSearch.with(ids: response.genreIds)

        return Model.Movie(title: response.title,
                           posterUrl: posterUrl,
                           genres: genres,
                           backdropUrl: backdropUrl,
                           overview: response.overview,
                           releaseDate: response.releaseDate)
    }

    func handleMovieResult(
        result: Result<ResponseModel.UpcomingMovies, Error>,
        page: Int,
        completion: @escaping Completion<[Model.Movie]>) {
        switch result {
        case let .success(movies):
            fetchConfiguration(movies, updateCurrentPageCompletion(to: page, completion))
        case let .failure(error):
            completion(.failure(error))
        }
    }

    func updateCurrentPageCompletion(
        to page: Int,
        _ completion: @escaping Completion<[Model.Movie]>) -> Completion<[Model.Movie]> {
        return { result in
            switch result {
            case let .success(movies):
                self.currentPage = page
                completion(.success(movies))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
