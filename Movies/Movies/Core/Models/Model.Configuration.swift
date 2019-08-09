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
