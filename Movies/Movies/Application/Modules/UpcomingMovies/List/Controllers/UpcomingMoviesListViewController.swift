import UIKit

final class UpcomingMoviesListViewController: UIViewController {
    // MARK: - Type alias
    typealias View = UIView & UpcomingMoviesListViewProtocol

    // MARK: - Properties
    // swiftlint:disable:next weak_delegate
    private let _layoutDelegate = UpcomingMoviesListLayoutDelegate()
    private let _view: View

    var didSelectUpcomingMovie = Delegated<Void, Void>()

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
}

// MARK: - UICollectionViewDataSource extension
extension UpcomingMoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(for: indexPath) as UpcomingMovieCollectionViewCell
    }
}

// MARK: - Private extension
private extension UpcomingMoviesListViewController {
    func setupView() {
        title = "Movies"

        _view.collectionView.dataSource = self
        _view.collectionView.delegate = _layoutDelegate

        _view.collectionView.register(cellType: UpcomingMovieCollectionViewCell.self)
        _layoutDelegate.didSelectItem.delegate { self.didSelectItem(at: $0) }
    }

    func didSelectItem(at indexPath: IndexPath) {
        didSelectUpcomingMovie.call()
    }
}
