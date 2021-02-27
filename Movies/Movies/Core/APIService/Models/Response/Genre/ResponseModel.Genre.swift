// swiftlint:disable file_types_order

extension ResponseModel {
    struct Genre {
        // MARK: - Properties
        let id: Int
        let name: String
    }
}

// MARK: - Decodable extension
extension ResponseModel.Genre: Decodable { }

// swiftlint:enable file_types_order
