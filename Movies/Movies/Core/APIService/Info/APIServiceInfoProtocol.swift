protocol APIServiceInfoProtocol {
    var baseURL: URLConvertible { get }
    var version: String { get }
    var apiKey: String { get }
}
