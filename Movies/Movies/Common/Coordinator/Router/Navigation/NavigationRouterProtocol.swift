protocol NavigationRouterProtocol: RouterProtocol {
    typealias Completion = () -> Void

    func show(_ module: Module, animated: Bool, completion: Completion?)
    func backToRootModule(animatedWith animation: NavigationRouterBackAnimation, completion: Completion?)
    func backTo(_ module: Module, animatedWith animation: NavigationRouterBackAnimation, completion: Completion?)
}
