import struct CoreGraphics.CGFloat
import class UIKit.NSLayoutConstraint
import class UIKit.NSLayoutDimension

protocol LayoutDimension: LayoutAnchor {
    func constraint(equalToConstant constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualToConstant constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutDimension: LayoutDimension { }
