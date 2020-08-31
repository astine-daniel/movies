extension ResponseModel {
    struct Genre {
        // MARK: - Properties
        let id: Int
        let name: String
    }
}

// MARK: - Decodable extension
extension ResponseModel.Genre: Decodable { }
