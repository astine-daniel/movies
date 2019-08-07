import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        enableLargeTitles()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backButtonWithoutTitle = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButtonWithoutTitle

        super.pushViewController(viewController, animated: animated)
    }
}

private extension NavigationController {
    func enableLargeTitles() {
        guard #available(iOS 11.0, *) else { return }
        navigationBar.prefersLargeTitles = true
    }
}
