import struct CoreGraphics.CGRect

import class Foundation.NSCoder

import class UIKit.UIView
import class UIKit.UICollectionView

final class UpcomingMoviesListView: UIView {
    // MARK: - Outlets
    @IBOutlet private var _contentView: UIView!
    @IBOutlet private var _collectionView: UICollectionView!

    // MARK: - Initialization
    required init() {
        super.init(frame: .zero)

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UpcomingMoviesListViewProtocol extension
extension UpcomingMoviesListView: UpcomingMoviesListViewProtocol {
}

// MARK: - NibOwnerLoadable extension
extension UpcomingMoviesListView: NibOwnerLoadable { }

// MARK: - Private extension
private extension UpcomingMoviesListView {
    func commonInit() {
        loadNibContent()
    }
}
