extension ResponseModel {
    struct Configuration {
        let images: Images
        let changeKeys: [String]
    }
}

// MARK: - Configuration decodable extension
extension ResponseModel.Configuration: Decodable {
}

// MARK: - Configuration.Images
extension ResponseModel.Configuration {
    struct Images {
        let baseUrl: String
        let secureBaseUrl: String
        let backdropSizes: [String]
        let logoSizes: [String]
        let posterSizes: [String]
        let profileSizes: [String]
        let stillSizes: [String]
    }
}

// MARK: - Configuration.Images decodable extension
extension ResponseModel.Configuration.Images: Decodable {
}
