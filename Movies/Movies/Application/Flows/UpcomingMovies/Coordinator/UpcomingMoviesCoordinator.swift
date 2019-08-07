import UIKit

final class UpcomingMoviesCoordinator: Coordinator {
    // MARK: - Properties
    private let router: NavigationRouterProtocol

    // MARK: - Initialization
    required init(router: NavigationRouterProtocol) {
        self.router = router

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
    }

    func showUpcomingMovieDetailScreen() {
        let presentable = UpcomingMovieDetailViewController()
        presentable.title = "Detail"

        router.show(presentable, animated: true, completion: nil)
    }
}
