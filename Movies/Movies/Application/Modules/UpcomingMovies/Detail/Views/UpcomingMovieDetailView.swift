import UIKit

final class UpcomingMovieDetailView: UIView {
    // MARK: - Outlets
    @IBOutlet private var _contentView: UIView!
    @IBOutlet private var _scrollView: UIScrollView!
    @IBOutlet private var _scrollContentView: UIView!

    @IBOutlet private var _posterImageView: UIImageView! {
        didSet {
            _posterImageView.backgroundColor = .white
            _posterImageView.image = nil
        }
    }

    @IBOutlet private var _titleLabel: UILabel! {
        didSet {
            _titleLabel.text = nil
            _titleLabel.font = .systemFont(ofSize: 14.0, weight: .bold)
            _titleLabel.numberOfLines = 0
        }
    }

    @IBOutlet private var _releaseDateLabel: UILabel! {
        didSet {
            _releaseDateLabel.text = nil
            _releaseDateLabel.font = .systemFont(ofSize: 12.0)
            _releaseDateLabel.numberOfLines = 1
        }
    }

    @IBOutlet private var _genresLabel: UILabel! {
        didSet {
            _genresLabel.text = nil
            _genresLabel.font = .systemFont(ofSize: 12.0, weight: .light)
            _genresLabel.numberOfLines = 0
        }
    }

    @IBOutlet private var _overviewLabel: UILabel! {
        didSet {
            _overviewLabel.text = "Overview"
            _overviewLabel.font = .systemFont(ofSize: 22.0, weight: .bold)
            _overviewLabel.numberOfLines = 1
        }
    }

    @IBOutlet private var _overviewContentLabel: UILabel! {
        didSet {
            _overviewContentLabel.text = nil
            _overviewContentLabel.font = .systemFont(ofSize: 15.0)
            _overviewContentLabel.numberOfLines = 0
        }
    }

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

// MARK: - UpcomingMovieDetailViewProtocol extension
extension UpcomingMovieDetailView: UpcomingMovieDetailViewProtocol {
    var posterImageView: UIImageView { _posterImageView }
    var titleLabel: UILabel { _titleLabel }
    var releaseDateLabel: UILabel { _releaseDateLabel }
    var genresLabel: UILabel { _genresLabel }
    var overviewLabel: UILabel { _overviewContentLabel }
}

// MARK: - NibOwnerLoadable extension
extension UpcomingMovieDetailView: NibOwnerLoadable { }

// MARK: - Private extension
private extension UpcomingMovieDetailView {
    func commonInit() {
        loadNibContent()
    }
}
