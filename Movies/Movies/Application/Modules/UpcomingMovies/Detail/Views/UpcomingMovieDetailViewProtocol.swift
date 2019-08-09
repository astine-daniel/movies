import UIKit

protocol UpcomingMovieDetailViewProtocol: AnyObject {
    var posterImageView: UIImageView { get }
    var titleLabel: UILabel { get }
    var releaseDateLabel: UILabel { get }
    var genresLabel: UILabel { get }
    var overviewLabel: UILabel { get }
}
