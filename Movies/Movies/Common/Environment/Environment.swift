import Foundation

enum Environment: String {
    case development = "Development"
    case production = "Production"
    case staging = "Staging"
}

extension Environment {
    static var current: Environment { from(Bundle.main) }

    static func from(_ projectInfo: ProjectInfo) -> Environment { projectInfo.environment }
}

extension ProjectInfo {
    var environment: Environment {
        let environmentNameKey = "Environment"

        guard let environmentName = infos?[environmentNameKey] as? String,
            let environment = Environment(rawValue: environmentName) else {
                return .development
        }

        return environment
    }
}
