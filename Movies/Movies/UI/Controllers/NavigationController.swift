import UIKit

final class NavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backButtonWithoutTitle = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = backButtonWithoutTitle

        super.pushViewController(viewController, animated: animated)
    }
}
