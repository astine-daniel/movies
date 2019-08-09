import UIKit

final class UpcomingMovieDetailViewController: UIViewController {
    // MARK: - Type alias
    typealias View = UIView & UpcomingMovieDetailViewProtocol

    // MARK: - Properties
    private let _view: View

    // MARK: - Initializers
    required init(_ view: View) {
        _view = view
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func loadView() {
        view = _view
    }

    // MARK: Methods
    func setup(_ movie: Model.Movie) {
        _view.posterImageView.load(url: movie.posterUrl)

        _view.titleLabel.text = movie.title
        _view.releaseDateLabel.text = movie.releaseDate.monthDayYearFormat
        _view.genresLabel.text = movie.genres.joined(separator: ", ")
        _view.overviewLabel.text = movie.overview
    }
}
