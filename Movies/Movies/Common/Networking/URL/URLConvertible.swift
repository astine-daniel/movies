import Foundation

protocol URLConvertible {
    func asURL() throws -> URL
}

// MARK: - String extension
extension String: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkingError.invalidURL(url: self) }
        return url
    }
}

// MARK: - URL extension
extension URL: URLConvertible {
    func asURL() throws -> URL { self }
}

// MARK: - URLComponents
extension URLComponents: URLConvertible {
    func asURL() throws -> URL {
        guard let url = url else { throw NetworkingError.invalidURL(url: self) }
        return url
    }
}
