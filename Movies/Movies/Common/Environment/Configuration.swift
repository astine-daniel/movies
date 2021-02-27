import Foundation

enum Configuration: String {
    case debug = "Debug"
    case release = "Release"
}

extension Configuration {
    static var current: Configuration {
        from(Bundle.main)
    }

    static func from(_ projectInfo: ProjectInfo) -> Configuration {
        projectInfo.configuration
    }
}

extension ProjectInfo {
    var configuration: Configuration {
        let configurationNameKey = "Configuration"

        guard let configurationName = infos?[configurationNameKey] as? String,
            let configuration = Configuration(rawValue: configurationName) else {
                return .debug
        }

        return configuration
    }
}
