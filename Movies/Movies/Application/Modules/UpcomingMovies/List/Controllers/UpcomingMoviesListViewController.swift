import UIKit

final class UpcomingMoviesListViewController: UIViewController {
    // MARK: - Type alias
    typealias View = UIView & UpcomingMoviesListViewProtocol

    // MARK: - Properties
    var didSelectUpcomingMovie = Delegated<Model.Movie, Void>()
    var didRequestMoreItems = Delegated<Void, Void>()

    private var _movies: [Model.Movie] = []
    private var _filteredMovies: [Model.Movie] = []
    private var isRequestingMoreItems: Bool = false
    private var isSearching: Bool = false
    private var searchString: String = ""

    // swiftlint:disable:next weak_delegate
    private let _layoutDelegate = UpcomingMoviesListLayoutDelegate()
    private let _view: View
    private let _searchController = UISearchController(searchResultsController: nil)

    private weak var _activityIndicatorView: UIActivityIndicatorView?

    // MARK: - Initializers
    required init(_ view: View) {
        self._view = view

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSearchController()

        definesPresentationContext = true
    }

    // MARK: - Methods
    func showLoading() {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        _view.collectionView.backgroundView = activityIndicatorView

        activityIndicatorView.startAnimating()
        _activityIndicatorView = activityIndicatorView
    }

    func hideLoading() {
        _activityIndicatorView?.stopAnimating()
        _view.collectionView.backgroundView = nil
    }

    func show(movies: [Model.Movie]) {
        if isSearching {
            search(movies: movies)
        } else {
            add(movies: movies)
        }
    }
}

// MARK: - UICollectionViewDataSource extension
extension UpcomingMoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if isSearching { return _filteredMovies.count }
        if isRequestingMoreItems { return _movies.count + 1 }

        return _movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.item < _movies.count else {
            return loadingCell(for: indexPath, collectionView)
        }

        return upcomingMovieCell(for: indexPath, collectionView)
    }
}

// MARK: - UISearchBarDelegate extension
extension UpcomingMoviesListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false

        guard _filteredMovies.isEmpty == false else { return }
        _filteredMovies = []
        _view.collectionView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        _view.collectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        _view.collectionView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating extension
extension UpcomingMoviesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchString = searchController.searchBar.text.orDefault("")
        filterMovies()
        _view.collectionView.reloadData()
    }
}

// MARK: - Private extension
private extension UpcomingMoviesListViewController {
    func setupView() {
        _view.backgroundColor = .white
        _view.collectionView.dataSource = self
        _view.collectionView.delegate = _layoutDelegate

        _view.collectionView.register(cellType: UpcomingMovieCollectionViewCell.self)
        _view.collectionView.register(cellType: LoadingCardCollectionViewCell.self)

        _layoutDelegate.didSelectItem.delegate(to: self) { (self, indexPath) in self.didSelectItem(at: indexPath) }
        _layoutDelegate.didRequestMoreItems.delegate(to: self) { (self, _) in
            self.requestMoreItems()
        }

        if #available(iOS 11, *) {
        } else {
            if let topConstraint = _view.constraints.first(where: { $0.firstAttribute == .top }) {
                _view.removeConstraint(topConstraint)
            }

            _view.contentView.layout {
                $0.top == topLayoutGuide.bottomAnchor
            }
        }
    }

    func setupSearchController() {
        _searchController.searchResultsUpdater = self
        _searchController.searchBar.delegate = self

        _searchController.hidesNavigationBarDuringPresentation = false
        _searchController.dimsBackgroundDuringPresentation = false
        _searchController.obscuresBackgroundDuringPresentation = false

        _searchController.searchBar.placeholder = "Search by movie name"

        if #available(iOS 11.0, *) {
            navigationItem.searchController = _searchController
        } else {
            _view.add(searchBar: _searchController.searchBar)
            edgesForExtendedLayout = .bottom
        }
    }

    func requestMoreItems() {
        guard isRequestingMoreItems == false && _movies.isEmpty == false else { return }
        isRequestingMoreItems = true

        if isSearching == false {
            let insertIndexPath = IndexPath(item: _movies.count, section: 0)
            _view.collectionView.performBatchUpdates({
                _view.collectionView.insertItems(at: [insertIndexPath])
            })
        }

        didRequestMoreItems.call()
    }

    func upcomingMovieCell(for indexPath: IndexPath, _ collectionView: UICollectionView) -> UpcomingMovieCollectionViewCell {
        let cell: UpcomingMovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(movie(at: indexPath))

        return cell
    }

    func loadingCell(for indexPath: IndexPath, _ collectionView: UICollectionView) -> LoadingCardCollectionViewCell {
        let cell: LoadingCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.startLoading()

        return cell
    }

    func didSelectItem(at indexPath: IndexPath) {
        didSelectUpcomingMovie.call(movie(at: indexPath))
    }

    func add(movies: [Model.Movie]) {
        let insertIndexPaths = (_movies.count ..< (_movies.count + movies.count)).map {
            IndexPath(item: $0, section: 0)
        }

        var deleteIndexPaths: [IndexPath] = []
        if isRequestingMoreItems {
            isRequestingMoreItems = false
            deleteIndexPaths.append(IndexPath(item: _movies.count, section: 0))
        }

        _movies.append(contentsOf: movies)

        _view.collectionView.performBatchUpdates({
            _view.collectionView.deleteItems(at: deleteIndexPaths)
            _view.collectionView.insertItems(at: insertIndexPaths)
        })
    }

    func search(movies: [Model.Movie]) {
        isRequestingMoreItems = false

        _movies.append(contentsOf: movies)
        filterMovies()
        _view.collectionView.reloadData()
    }

    func filterMovies() {
        guard isSearching else { return }

        guard searchString.isEmpty == false else {
            _filteredMovies = []
            return
        }

        _filteredMovies = _movies.filter { $0.title.contains(searchString) }
    }

    func movie(at indexPath: IndexPath) -> Model.Movie {
        if isSearching { return _filteredMovies[indexPath.item] }
        return _movies[indexPath.item]
    }
}
