import UIKit

final class UpcomingMovieDetailView: UIView {
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

    // MARK: - Outlets
    @IBOutlet private var _contentView: UIView!
    @IBOutlet private var _scrollView: UIScrollView!
    @IBOutlet private var _scrollContentView: UIView!

    @IBOutlet private var _posterImageView: UIImageView!
    @IBOutlet private var _titleLabel: UILabel!
    @IBOutlet private var _releaseDateLabel: UILabel!
    @IBOutlet private var _genresLabel: UILabel!
    @IBOutlet private var _overviewLabel: UILabel!
    @IBOutlet private var _overviewContentLabel: UILabel!
}

// MARK: - NibOwnerLoadable extension
extension UpcomingMovieDetailView: NibOwnerLoadable { }

// MARK: - Private extension
private extension UpcomingMovieDetailView {
    func commonInit() {
        loadNibContent()
    }
}
