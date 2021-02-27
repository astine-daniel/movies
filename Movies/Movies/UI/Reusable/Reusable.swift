protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

// MARK: - Default implementation
extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}
