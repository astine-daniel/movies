import Foundation

protocol ResourceParser {
    func parse<T: Decodable>(_ data: Data?) throws -> T
}
