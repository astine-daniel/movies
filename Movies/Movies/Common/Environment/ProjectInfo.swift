import Foundation

protocol ProjectInfo {
    typealias Infos = [String: Any]

    var infos: Infos? { get }
}

extension Bundle: ProjectInfo {
    var infos: Infos? { return infoDictionary }
}
