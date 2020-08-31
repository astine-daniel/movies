import UIKit

extension NibOwnerLoadable where Self: UIView {
    func loadNibContent() {
        for case let view as UIView in Self.nib.instantiate(withOwner: self, options: nil) {
            addSubview(view)
            view.layout {
                $0.top == topAnchor
                $0.trailing == trailingAnchor
                $0.bottom == bottomAnchor
                $0.leading == leadingAnchor
            }
        }
    }
}
