import Foundation

struct Request {
    let urlRequest: URLRequest

    private (set) var state: State
    private (set) var task: URLSessionTask?

    init(state: State, task: URLSessionTask? = nil, urlRequest: URLRequest) {
        self.state = state
        self.task = task
        self.urlRequest = urlRequest
    }
}

extension Request {
    mutating func resume() {
        guard state.canTransitionTo(.resumed) else { return }
        state = .resumed

        guard task?.state != .completed else {
            finished()
            return
        }

        task?.resume()
    }

    mutating func suspend() {
        guard state.canTransitionTo(.suspended) else { return }
        state = .suspended

        guard task?.state != .completed else {
            finished()
            return
        }

        task?.suspend()
    }

    mutating func cancel() {
        guard state.canTransitionTo(.cancelled) else { return }
        state = .cancelled

        guard task?.state != .completed else {
            finished()
            return
        }

        task?.cancel()
    }
}

private extension Request {
    mutating func finished() {
        state = .finished
    }
}

// MARK: - Request State
extension Request {
    enum State {
        case initialized
        case resumed
        case suspended
        case cancelled
        case finished

        func canTransitionTo(_ state: State) -> Bool {
            switch (self, state) {
            case (.initialized, _):
                return true
            case (_, .initialized),
                 (.cancelled, _),
                 (.finished, _):
                return false
            case (.resumed, .cancelled),
                 (.suspended, .cancelled),
                 (.resumed, .suspended),
                 (.suspended, .resumed):
                return true
            case (.suspended, .suspended),
                 (.resumed, .resumed):
                return false
            case (_, .finished):
                return true
            }
        }
    }
}
