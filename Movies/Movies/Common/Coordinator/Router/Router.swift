final class Router {
    // MARK: - Properties
    private (set) var rootScreen: ScreenProtocol

    // MARK: - Initialization
    init(rootScreen: ScreenProtocol) {
        self.rootScreen = rootScreen
    }
}

// MARK: - RouterProtocol extension
extension Router: RouterProtocol {
    func setRoot(_ module: Module, animated: Bool) {
        let screen = module.toPresent()
        rootScreen.present(screen, style: .main(animated: animated))
    }

    func present(_ module: Module, animated: Bool) {
        let screen = module.toPresent()
        rootScreen.present(screen, style: .modal(animated: animated))
    }

    func dismiss(_ module: Module, animated: Bool) {
        rootScreen.dismiss(animated: animated)
    }
}
