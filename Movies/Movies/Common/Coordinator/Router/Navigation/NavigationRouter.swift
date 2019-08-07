import Foundation
import UIKit

final class NavigationRouter: NSObject {
    typealias NavigationScreen = UINavigationController & ScreenProtocol

    private (set) var navigationScreen: NavigationScreen

    private var completions: [UIViewController: Completion]
    private weak var snapshotView: UIView?

    required init(navigationScreen: NavigationScreen) {
        self.navigationScreen = navigationScreen
        completions = [:]

        super.init()

        navigationScreen.delegate = self
    }
}

extension NavigationRouter: NavigationRouterProtocol {
    var rootScreen: ScreenProtocol { return navigationScreen }

    func setRoot(_ module: Module, animated: Bool) {
        completions.forEach { $0.value() }
        completions.removeAll()

        let module = module.toPresent()
        navigationScreen.present(module, style: .main(animated: animated))
    }

    func show(_ module: Module, animated: Bool, completion: Completion?) {
        guard navigationScreen.viewControllers.isEmpty == false else {
            setRoot(module, animated: animated)
            return
        }

        guard let viewController = module.toPresent() as? UIViewController else { return }
        if let completion = completion {
            completions[viewController] = completion
        }

        navigationScreen.present(viewController, style: .show(animated: animated))
    }

    func backTo(_ module: Module,
                animatedWith animation: NavigationRouterBackAnimation = .normal,
                completion: Completion?) {
        guard navigationScreen.viewControllers.count > 1 else { return }

        guard let viewController = module.toPresent() as? UIViewController else { return }
        backTo(viewController: viewController, animatedWith: animation, completion: completion)
    }

    func backToRootModule(animatedWith animation: NavigationRouterBackAnimation, completion: Completion?) {
        guard navigationScreen.viewControllers.count > 1,
            let viewController = navigationScreen.viewControllers.first else {
                return
        }

        backTo(viewController: viewController, animatedWith: animation, completion: completion)
    }

    func present(_ module: Module, animated: Bool) {
        let module = module.toPresent()
        navigationScreen.present(module, style: .modal(animated: animated))
    }

    func dismiss(_ module: Module, animated: Bool) {
        navigationScreen.dismiss(animated: animated)
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        guard let poppedViewController = navigationController
            .transitionCoordinator?.viewController(forKey: .from) else {
                return
        }

        guard navigationController.viewControllers.contains(poppedViewController) == false else { return }

        runCompletion(for: poppedViewController)
    }
}

private extension NavigationRouter {
    func runCompletion(for viewController: UIViewController) {
        guard let completion = completions.removeValue(forKey: viewController) else { return }
        completion()
    }

    func backTo(viewController: UIViewController,
                animatedWith animation: NavigationRouterBackAnimation,
                completion: Completion?) {
        var customCompletion: Completion = {
            completion?()
        }

        switch animation {
        case .none:
            completions[navigationScreen.visibleViewController!] = customCompletion
            backTo(viewController: viewController, animated: false)
        case .normal:
            completions[navigationScreen.visibleViewController!] = customCompletion
            backTo(viewController: viewController)
        case .fade:
            customCompletion = { [weak self] in
                self?.completeBackTransitionWithFadeAnimation()
                completion?()
            }

            completions[navigationScreen.visibleViewController!] = customCompletion
            fadeTo(viewController: viewController)
        }
    }

    func backTo(viewController: UIViewController?, animated: Bool = true) {
        guard let viewController = viewController else { return }

        guard navigationScreen.viewControllers.contains(viewController) else {
            backTo(viewController: viewController.parent, animated: animated)
            return
        }

        guard let poppedViewControllers = navigationScreen
            .popToViewController(viewController, animated: animated) else {
                return
        }

        poppedViewControllers.forEach { runCompletion(for: $0) }
    }

    func fadeTo(viewController: UIViewController) {
        guard let snapshotView = navigationScreen.visibleViewController?
            .view.snapshotView(afterScreenUpdates: true) else { return }

        navigationScreen.view.addSubview(snapshotView)
        self.snapshotView = snapshotView

        backTo(viewController: viewController, animated: false)
    }

    func completeBackTransitionWithFadeAnimation() {
        guard let snapshotView = snapshotView else { return }

        UIView.animate(withDuration: 1.0, animations: {
            snapshotView.alpha = 0.0
        }, completion: { _ in
            snapshotView.removeFromSuperview()
        })
    }
}
