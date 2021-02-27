import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        enableLargeTitles()
    }
}

// MARK: - Private extension
private extension NavigationController {
    func enableLargeTitles() {
        guard #available(iOS 11.0, *) else { return }
        navigationBar.prefersLargeTitles = true
    }
}
