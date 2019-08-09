import Foundation

extension Model {
    struct Movie {
        let title: String
        let posterUrl: URL?
        let genres: [String]
        let backdropUrl: URL?
        let overview: String
        let releaseDate: Date
    }
}
