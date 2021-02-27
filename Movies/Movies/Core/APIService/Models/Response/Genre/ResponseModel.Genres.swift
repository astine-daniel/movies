// swiftlint:disable file_types_order

extension ResponseModel {
    struct Genres {
        // MARK: - Properties
        let genres: [Genre]
    }
}

// MARK: - Decodable extension
extension ResponseModel.Genres: Decodable { }

// swiftlint:enable file_types_order
