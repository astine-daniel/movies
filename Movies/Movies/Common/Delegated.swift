struct Delegated<Input, Output> {
    private var _callback: ((Input) -> Output?)?

    var isDelegateSet: Bool { _callback != nil }

    mutating func delegate<Target: AnyObject>(to target: Target, with callback: @escaping (Target, Input) -> Output) {
        _callback = { [weak target] input in
            guard let target = target else { return nil }
            return callback(target, input)
        }
    }

    mutating func delegate(_ callback: @escaping (Input) -> Output) {
        _callback = { input in
            callback(input)
        }
    }

    func call(_ input: Input) -> Output? {
        _callback?(input)
    }
}

extension Delegated {
    mutating func removeDelegate() {
        _callback = nil
    }
}

extension Delegated where Input == Void {
    mutating func delegate<Target: AnyObject>(to target: Target, with callback: @escaping (Target) -> Output) {
        delegate(to: target) { target, _ in callback(target) }
    }

    mutating func delegate(_ callback: @escaping () -> Output) {
        delegate { _ in callback() }
    }

    func call() -> Output? {
        self.call(())
    }
}

extension Delegated where Output == Void {
    func call(_ input: Input) {
        _callback?(input)
    }
}

extension Delegated where Input == Void, Output == Void {
    func call() {
        self.call(())
    }
}

extension Delegated where Input: OptionalType {
    func call() -> Output? {
        _callback?(nil)
    }
}

extension Delegated where Input: OptionalType, Output == Void {
    func call() {
        _callback?(nil)
    }
}
