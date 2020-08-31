import UIKit

final class LoadingCardCollectionViewCell: CardCollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet private var _contentView: UIView! {
        didSet {
            _contentView.backgroundColor = backgroundColor
        }
    }

    @IBOutlet private var _activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            _activityIndicatorView.hidesWhenStopped = true
            _activityIndicatorView.style = .gray
        }
    }
}

// MARK: - Methods
extension LoadingCardCollectionViewCell {
    func startLoading() {
        _activityIndicatorView.startAnimating()
    }
}

// MARK: - NibReusable extension
extension LoadingCardCollectionViewCell: NibReusable { }
