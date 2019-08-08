import Foundation

struct ClosureResourceParser<U: Decodable> {
    // MARK: - Properties
    private var closure: (Data?) throws -> U

    // MARK: - Initialization
    init(_ closure: @escaping (Data?) throws -> U) {
        self.closure = closure
    }
}

// MARK: - ResourceParser extension
extension ClosureResourceParser: ResourceParser {
    func parse<T>(_ data: Data?) throws -> T {
        guard let parsedData = try closure(data) as? T else {
            throw NetworkingError.parseFailed(type: T.self)
        }

        return parsedData
    }
}
