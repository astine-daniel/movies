import UIKit

final class UpcomingMovieCollectionViewCell: CardCollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()

        _backdropImageView.backgroundColor = .white
        _backdropImageView.image = nil

        _posterImageView.backgroundColor = .white
        _posterImageView.image = nil

        _releaseDateLabel.text = nil
        _titleLabel.text = nil
        _genresLabel.text = nil
    }

    // MARK: - IBOutlets
    @IBOutlet private var _contentView: UIView! {
        didSet {
            _contentView.backgroundColor = backgroundColor
        }
    }

    @IBOutlet private var _backdropImageView: UIImageView! {
        didSet {
            _backdropImageView.backgroundColor = .white
            _backdropImageView.contentMode = .scaleAspectFill
            _backdropImageView.image = nil
        }
    }

    @IBOutlet private var _movieInfoContentView: UIView! {
        didSet {
            _movieInfoContentView.backgroundColor = .white
        }
    }

    @IBOutlet private var _posterImageView: UIImageView! {
        didSet {
            _posterImageView.backgroundColor = .white
            _posterImageView.contentMode = .scaleAspectFill
            _posterImageView.image = nil
        }
    }

    @IBOutlet private var _releaseDateLabel: UILabel! {
        didSet {
            _releaseDateLabel.font = .systemFont(ofSize: 12.0, weight: .bold)
            _releaseDateLabel.text = nil
        }
    }

    @IBOutlet private var _titleLabel: UILabel! {
        didSet {
            _titleLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
            _titleLabel.textColor = .black
            _titleLabel.text = nil
        }
    }

    @IBOutlet private var _genresLabel: UILabel! {
        didSet {
            _genresLabel.font = .systemFont(ofSize: 12)
            _genresLabel.text = nil
        }
    }
}

// MARK: - Methods
extension UpcomingMovieCollectionViewCell {
    func setup(_ movie: Model.Movie) {
        _titleLabel.text = movie.title
        _releaseDateLabel.text = movie.releaseDate.monthDayYearFormat
        _genresLabel.text = movie.genres.joined(separator: ", ")

        _backdropImageView.load(url: movie.backdropUrl)
        _posterImageView.load(url: movie.posterUrl)
    }
}

// MARK: - NibReusable extension
extension UpcomingMovieCollectionViewCell: NibReusable { }
