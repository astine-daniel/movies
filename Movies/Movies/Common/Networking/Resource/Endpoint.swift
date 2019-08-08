import Foundation

struct Endpoint {
    // MARK: - Properties
    let path: String
    let queryItems: [URLQueryItem]

    // MARK: - Properties
    init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}
