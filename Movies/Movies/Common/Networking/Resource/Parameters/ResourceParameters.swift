import Foundation

protocol ResourceParameters {
    func encode(on request: URLRequestConvertible) throws -> URLRequest
}
