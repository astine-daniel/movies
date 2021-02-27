class Coordinator {
    private (set) final var childCoordinators: [CoordinatorProtocol] = []

    func start() {
        guard type(of: self) != Coordinator.self else {
            fatalError("Method must be overridden")
        }
    }
}

extension Coordinator: CoordinatorProtocol { }

extension Coordinator {
    final func add(child coordinator: CoordinatorProtocol) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    final func remove(child coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll { $0 === coordinator }
    }

    final func removeAllChildCoordinator() {
        childCoordinators.removeAll(keepingCapacity: true)
    }
}
