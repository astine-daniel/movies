import UIKit

final class UpcomingMoviesCoordinator: Coordinator {
    // MARK: - Properties
    private let router: NavigationRouterProtocol
    private let repository: MoviesRepositoryProtocol

    // MARK: - Initialization
    required init(router: NavigationRouterProtocol, respository: MoviesRepositoryProtocol) {
        self.router = router
        self.repository = respository

        super.init()
    }

    // MARK: - Methods
    override func start() {
        showUpcomingMoviesListScreen()
    }
}

// MARK: - Presentable extension
extension UpcomingMoviesCoordinator: Presentable {
    func toPresent() -> ScreenProtocol { return router.rootScreen }
}

// MARK: - Private extension
private extension UpcomingMoviesCoordinator {
    func showUpcomingMoviesListScreen() {
        let view = UpcomingMoviesListView()
        let presentable = UpcomingMoviesListViewController(view)
        presentable.didSelectUpcomingMovie.delegate { _ in
            self.showUpcomingMovieDetailScreen()
        }

        presentable.title = "Movies"

        router.show(presentable, animated: true, completion: nil)

        fetchUpcomingMovies(presentable)
    }

    func showUpcomingMovieDetailScreen() {
        let presentable = UpcomingMovieDetailViewController()
        presentable.title = "Detail"

        router.show(presentable, animated: true, completion: nil)
    }

    func showError(_ error: Error, _ tryAgainAction: (() -> Void)?) {
        let tryAgainAlertAction = UIAlertAction(title: "Try again", style: .default) { _ in
            tryAgainAction?()
        }

        let alertController = UIAlertController(
            title: "Error",
            message: "Something went wrong: \(error.localizedDescription)",
            preferredStyle: .alert)
        alertController.addAction(tryAgainAlertAction)

        router.present(alertController, animated: true)
    }

    func fetchUpcomingMovies(_ presentable: UpcomingMoviesListViewController) {
        presentable.showLoading()
        repository.fetchUpcomingMovies { result in
            presentable.hideLoading()

            switch result {
            case let .success(movies):
                presentable.show(movies: movies)
            case let .failure(error):
                self.showError(error) {
                    self.fetchUpcomingMovies(presentable)
                }
            }
        }
    }
}
