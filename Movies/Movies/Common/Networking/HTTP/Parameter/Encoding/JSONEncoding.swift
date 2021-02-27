import Foundation

struct JSONEncoding {
    // MARK: - Properties
    private let options: JSONSerialization.WritingOptions

    // MARK: - Initialization
    init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
}

// MARK: - Default JSON encodings
extension JSONEncoding {
    static var `default`: JSONEncoding { JSONEncoding() }
    static var prettyPrinted: JSONEncoding { JSONEncoding(options: .prettyPrinted) }
}

// MARK: - ParameterEncoding extension
extension JSONEncoding: ParameterEncoding {
    func encode(_ parameters: Parameters?, into request: URLRequest) throws -> URLRequest {
        guard let parameters = parameters else { return request }

        do {
            var request = request
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)

            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.headers.add(.contentType(.json))
            }

            request.httpBody = data
        } catch {
            throw NetworkingError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }

        return request
    }
}
