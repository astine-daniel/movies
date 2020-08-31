import Foundation

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

// MARK: URLRequest extension
extension URLRequest: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest { return self }
}
