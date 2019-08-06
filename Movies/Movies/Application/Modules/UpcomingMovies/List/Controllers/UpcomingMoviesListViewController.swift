import class Foundation.NSCoder

import class UIKit.UIView
import class UIKit.UIViewController

final class UpcomingMoviesListViewController: UIViewController {
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
}
