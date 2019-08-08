import Foundation

protocol ParameterEncoding {
    typealias Parameters = [String: Any]

    func encode(_ parameters: Parameters?, into request: URLRequest) throws -> URLRequest
}
