import Foundation

protocol URLEncodedFormEncoderProtocol {
    func encode(_ value: Encodable) throws -> Data
    func encode(_ value: Encodable) throws -> String
}
