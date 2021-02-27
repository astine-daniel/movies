protocol APIServiceProtocol {
    typealias Completion<T> = (Result<T, Error>) -> Void

    @discardableResult
    func request<T>(_ resource: Resource, _ completion: @escaping Completion<T>) -> Request? where T: Decodable
}
