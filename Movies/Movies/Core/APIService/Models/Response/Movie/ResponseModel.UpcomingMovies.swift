import Foundation

extension ResponseModel {
    struct UpcomingMovies {
        let page: Int
        let totalPages: Int
        let movies: [ResponseModel.Movie]
    }
}

extension ResponseModel.UpcomingMovies: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let page: Int = try container.decode(Int.self, forKey: .page)
        let totalPages: Int = try container.decode(Int.self, forKey: .totalPages)
        let movies: [ResponseModel.Movie] = try container.decode([ResponseModel.Movie].self, forKey: .movies)

        self.init(page: page,
                  totalPages: totalPages,
                  movies: movies)
    }
}

private extension ResponseModel.UpcomingMovies {
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case movies = "results"
    }
}
