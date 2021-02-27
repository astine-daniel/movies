protocol OptionalType: ExpressibleByNilLiteral {
    associatedtype WrappedType

    var asOptional: WrappedType? { get }
}

extension Optional: OptionalType {
    var asOptional: Wrapped? { self }
}
