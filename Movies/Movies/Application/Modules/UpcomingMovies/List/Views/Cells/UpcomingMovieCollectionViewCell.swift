import UIKit

final class UpcomingMovieCollectionViewCell: CardCollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet private var _contentView: UIView! {
        didSet {
            _contentView.backgroundColor = backgroundColor
        }
    }

    @IBOutlet private var _backdropImageView: UIImageView! {
        didSet {
            _backdropImageView.backgroundColor = .darkGray
        }
    }

    @IBOutlet private var _movieInfoContentView: UIView! {
        didSet {
            _movieInfoContentView.backgroundColor = .white
        }
    }

    @IBOutlet private var _posterImageView: UIImageView! {
        didSet {
            _posterImageView.backgroundColor = .darkGray
        }
    }

    @IBOutlet private var _releaseDateLabel: UILabel! {
        didSet {
            _releaseDateLabel.font = .systemFont(ofSize: 12.0, weight: .bold)
        }
    }

    @IBOutlet private var _nameLabel: UILabel! {
        didSet {
            _nameLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
            _nameLabel.textColor = .black
        }
    }

    @IBOutlet private var _genresLabel: UILabel! {
        didSet {
            _genresLabel.font = .systemFont(ofSize: 12)
        }
    }
}

// MARK: - NibReusable extension
extension UpcomingMovieCollectionViewCell: NibReusable { }
