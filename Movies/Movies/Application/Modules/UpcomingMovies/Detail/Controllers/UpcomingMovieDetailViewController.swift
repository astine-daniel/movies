import UIKit

final class UpcomingMovieDetailViewController: UIViewController {
    // MARK: - Initializers
    required init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func loadView() {
        view = UpcomingMovieDetailView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

// MARK: - Private extension
private extension UpcomingMovieDetailViewController {
    func setupView() {
    }
}
