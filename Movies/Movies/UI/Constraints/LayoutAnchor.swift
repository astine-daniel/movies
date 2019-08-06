import struct CoreGraphics.CGFloat
import class UIKit.NSLayoutConstraint
import class UIKit.NSLayoutAnchor

protocol LayoutAnchor {
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor { }

// swiftlint:disable static_operator
// MARK: - Operators
func + <Anchor: LayoutAnchor>(lhs: Anchor, rhs: CGFloat) -> (Anchor, CGFloat) {
    return (lhs, rhs)
}

func - <Anchor: LayoutAnchor>(lhs: Anchor, rhs: CGFloat) -> (Anchor, CGFloat) {
    return (lhs, -rhs)
}

// swiftlint:enable static_operator
