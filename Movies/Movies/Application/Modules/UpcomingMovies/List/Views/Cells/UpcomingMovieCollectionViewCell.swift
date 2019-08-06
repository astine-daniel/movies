import UIKit

final class UpcomingMovieCollectionViewCell: UICollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()

        _backdropImageView.image = nil
        _posterImageView.image = nil
        _releaseDateLabel.text = nil
        _nameLabel.text = nil
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
            _releaseDateLabel.text = nil
        }
    }

    @IBOutlet private var _nameLabel: UILabel! {
        didSet {
            _nameLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
            _nameLabel.text = nil
            _nameLabel.textColor = .black
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
    static func size(in collectionSize: CGSize, interitemSpacing: Double, margin: Double) -> CGSize {
        let height: Double = 460.0
        var width: Double = 324.0

        let maxWidthWithMargin = (Double(collectionSize.width) - (margin * 2.0))

        guard maxWidthWithMargin > width else {
            width = maxWidthWithMargin
            return CGSize(width: width, height: height)
        }

        let itemsPerRow = (maxWidthWithMargin / width).rounded(.towardZero)
        guard itemsPerRow > 1 else {
            width = maxWidthWithMargin
            return CGSize(width: width, height: height)
        }

        let totalInteritemSpacing = interitemSpacing * (itemsPerRow - 1)
        let totalWidthOfItems = width * itemsPerRow
        let diff = maxWidthWithMargin - (totalWidthOfItems - totalInteritemSpacing)

        guard diff == 0 else {
            width += (diff.magnitude / (itemsPerRow - 1))
            return CGSize(width: width, height: height)
        }

        return CGSize(width: width, height: height)
    }
}

extension UpcomingMovieCollectionViewCell: NibReusable { }

private extension UpcomingMovieCollectionViewCell {
    func formatted(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"

        return dateFormatter.string(from: date)
    }

    func genres(from genres: [Int]) -> String {
        return genres
            .map { "\($0)" }
            .joined(separator: ", ")
    }
}
