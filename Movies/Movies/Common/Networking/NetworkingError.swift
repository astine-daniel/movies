enum NetworkingError: Error {
    case invalidURL(url: URLConvertible)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case parameterEncoderFailed(reason: ParameterEncoderFailureReason)
    case unexpected(error: Error)
    case parseFailed(type: Any.Type)
    case statusCode(code: Int)
    case unknown
}

extension NetworkingError {
    static func error(from statusCode: Int, validCodes: [Int] = [Int]()) -> NetworkingError? {
        var validCodes = validCodes
        validCodes.append(contentsOf: [Int](200..<300))

        guard validCodes.contains(statusCode) else {
            return .statusCode(code: statusCode)
        }

        return nil
    }
}

extension NetworkingError {
    // MARK: - ParameterEnconding reasons
    enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
    }
}

extension NetworkingError {
    enum ParameterEncoderFailureReason {
        case missingRequiredComponent(RequiredComponent)
        case encoderFailed(error: Error)
    }
}

extension NetworkingError.ParameterEncoderFailureReason {
    enum RequiredComponent {
        case url
        case httpMethod(rawValue: String)
    }
}
