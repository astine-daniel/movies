import UIKit

final class UpcomingMoviesListViewController: UIViewController {
    // MARK: - Type alias
    typealias View = UIView & UpcomingMoviesListViewProtocol

    // MARK: - Properties
    // swiftlint:disable:next weak_delegate
    private let _layoutDelegate = UpcomingMoviesListLayoutDelegate()
    private let _view: View
    private weak var _activityIndicatorView: UIActivityIndicatorView?

    private var _movies: [Model.Movie] = []
    private var isRequestingMoreItems: Bool = false

    var didSelectUpcomingMovie = Delegated<Model.Movie, Void>()
    var didRequestMoreItems = Delegated<Void, Void>()

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
        let insertIndexPaths = (_movies.count ..< (_movies.count + movies.count)).map {
            IndexPath(item: $0, section: 0)
        }

        _movies.append(contentsOf: movies)

        _view.collectionView.performBatchUpdates({
            _view.collectionView.insertItems(at: insertIndexPaths)
        })
    }
}

// MARK: - UICollectionViewDataSource extension
extension UpcomingMoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if isRequestingMoreItems {
            return _movies.count + 1
        }

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

// MARK: - Private extension
private extension UpcomingMoviesListViewController {
    func setupView() {
        _view.collectionView.dataSource = self
        _view.collectionView.delegate = _layoutDelegate

        _view.collectionView.register(cellType: UpcomingMovieCollectionViewCell.self)
        _view.collectionView.register(cellType: LoadingCardCollectionViewCell.self)

        _layoutDelegate.didSelectItem.delegate { self.didSelectItem(at: $0) }
        _layoutDelegate.didRequestMoreItems.delegate { _ in
            self.requestMoreItems()
        }
    }

    func requestMoreItems() {
        guard isRequestingMoreItems == false && _movies.isEmpty == false else { return }
        isRequestingMoreItems = true

        let insertIndexPath = IndexPath(item: _movies.count, section: 0)
        _view.collectionView.performBatchUpdates({
            _view.collectionView.insertItems(at: [insertIndexPath])
        })

        didRequestMoreItems.call()
    }

    func upcomingMovieCell(for indexPath: IndexPath, _ collectionView: UICollectionView) -> UpcomingMovieCollectionViewCell {
        let cell: UpcomingMovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(_movies[indexPath.item])

        return cell
    }

    func loadingCell(for indexPath: IndexPath, _ collectionView: UICollectionView) -> LoadingCardCollectionViewCell {
        let cell: LoadingCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.startLoading()

        return cell
    }

    func didSelectItem(at indexPath: IndexPath) {
        didSelectUpcomingMovie.call(_movies[indexPath.item])
    }
}
