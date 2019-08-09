import Foundation

extension Model {
    struct Configuration {
        // MARK: - Properties
        let backdropSize: String
        let posterSize: String

        private let imageBaseUrl: URL?

        // MARK: - Initialization
        init(imageBaseUrl: URL?, backdropSize: String, posterSize: String) {
            self.imageBaseUrl = imageBaseUrl
            self.backdropSize = backdropSize
            self.posterSize = posterSize
        }
    }
}

// MARK: - Methods extension
extension Model.Configuration {
    func posterUrl(path: String) -> URL? {
        return imageUrl(path: path, size: posterSize)
    }

    func backdropUrl(path: String) -> URL? {
        return imageUrl(path: path, size: backdropSize)
    }
}

// MARK: - Private extension
private extension Model.Configuration {
    func imageUrl(path: String, size: String) -> URL? {
        return imageBaseUrl?.appendingPathComponent("\(size)/\(path)")
    }
}
