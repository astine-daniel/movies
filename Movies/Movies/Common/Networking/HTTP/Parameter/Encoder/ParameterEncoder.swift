import Foundation

protocol ParameterEncoder {
    func encode<Parameters: Encodable>(_ parameters: Parameters?, into request: URLRequest) throws -> URLRequest
}
