import UIKit

protocol NibLoadable: AnyObject {
    static var bundle: Bundle { get }
    static var nib: UINib { get }
}

// MARK: - Default implementation
extension NibLoadable {
    static var bundle: Bundle { return Bundle(for: self) }

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: bundle)
    }
}

extension NibLoadable where Self: Reusable {
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: bundle)
    }
}

typealias NibReusable = Reusable & NibLoadable
