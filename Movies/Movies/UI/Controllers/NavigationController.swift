import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        enableLargeTitles()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        setBackButton(makeBackButtonWithoutTitle(), in: viewController)
        super.pushViewController(viewController, animated: animated)
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        viewControllers.forEach { setBackButton(makeBackButtonWithoutTitle(), in: $0) }
        super.setViewControllers(viewControllers, animated: animated)
    }
}

// MARK: - Private extension
private extension NavigationController {
    func enableLargeTitles() {
        guard #available(iOS 11.0, *) else { return }
        navigationBar.prefersLargeTitles = true
    }

    func makeBackButtonWithoutTitle() -> UIBarButtonItem {
        return UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }

    func setBackButton(_ backButton: UIBarButtonItem, in viewController: UIViewController) {
        viewController.navigationItem.backBarButtonItem = backButton
    }
}
