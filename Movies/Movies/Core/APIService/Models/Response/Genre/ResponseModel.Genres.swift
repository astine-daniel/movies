extension ResponseModel {
    struct Genres {
        // MARK: - Properties
        let genres: [Genre]
    }
}

// MARK: - Decodable extension
extension ResponseModel.Genres: Decodable { }
