import Foundation

// swiftlint:disable file_types_order

extension ResponseModel {
    struct Movie: Hashable {
        let id: Int
        let title: String
        let posterPath: String
        let genreIds: [Int]
        let backdropPath: String
        let overview: String
        let releaseDate: Date
    }
}

extension ResponseModel.Movie: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let id: Int = try container.decode(Int.self, forKey: .id)
        let title: String = try container.decode(String.self, forKey: .title)
        let posterPath: String = (try? container.decode(String.self, forKey: .posterPath)).orDefault("")
        let genreIds: [Int] = try container.decode([Int].self, forKey: .genreIds)
        let backdropPath: String = (try? container.decode(String.self, forKey: .backdropPath)).orDefault("")
        let overview: String = try container.decode(String.self, forKey: .overview)
        let releaseDateString: String = try container.decode(String.self, forKey: .releaseDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let releaseDate = dateFormatter.date(from: releaseDateString) else {
            throw NetworkingError.parseFailed(type: Date.self)
        }

        self.init(
            id: id,
            title: title,
            posterPath: posterPath,
            genreIds: genreIds,
            backdropPath: backdropPath,
            overview: overview,
            releaseDate: releaseDate
        )
    }
}

private extension ResponseModel.Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath
        case genreIds
        case backdropPath
        case overview
        case releaseDate
    }
}

// swiftlint:enable file_types_order
