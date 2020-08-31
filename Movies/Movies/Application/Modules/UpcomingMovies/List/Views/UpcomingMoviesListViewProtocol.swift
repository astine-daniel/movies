import UIKit

protocol UpcomingMoviesListViewProtocol: AnyObject {
    var contentView: UIView { get }
    var collectionView: UICollectionView { get }

    func add(searchBar: UISearchBar)
}
