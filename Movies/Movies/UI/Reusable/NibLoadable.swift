import UIKit

typealias NibReusable = Reusable & NibLoadable

protocol NibLoadable: AnyObject {
    static var bundle: Bundle { get }
    static var nib: UINib { get }
}

// MARK: - Default implementation
extension NibLoadable {
    static var bundle: Bundle { Bundle(for: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: bundle) }
}

extension NibLoadable where Self: Reusable {
    static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: bundle) }
}
