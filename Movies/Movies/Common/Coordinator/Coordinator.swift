class Coordinator {
    final private (set) var childCoordinators: [CoordinatorProtocol] = []

    func start() {
        guard type(of: self) != Coordinator.self else {
            fatalError("Method must be overridden")
        }
    }
}

extension Coordinator: CoordinatorProtocol { }

extension Coordinator {
    final func add(child coordinator: CoordinatorProtocol) {
        guard childCoordinators.first(where: { $0 === coordinator }) == nil else { return }
        childCoordinators.append(coordinator)
    }

    final func remove(child coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }

    final func removeAllChildCoordinator() {
        childCoordinators.removeAll(keepingCapacity: true)
    }
}
