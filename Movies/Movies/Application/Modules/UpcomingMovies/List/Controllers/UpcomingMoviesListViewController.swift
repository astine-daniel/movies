import UIKit

final class UpcomingMoviesListViewController: UIViewController {
    // MARK: - Type alias
    typealias View = UIView & UpcomingMoviesListViewProtocol

    // MARK: - Properties
    private let margin = 16.0
    private let listLayout = UpcomingMoviesListLayout()

    private let _view: View

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
        _view.collectionView.dataSource = self
        _view.collectionView.delegate = listLayout

        _view.collectionView.register(cellType: UpcomingMovieCollectionViewCell.self)
    }
}
