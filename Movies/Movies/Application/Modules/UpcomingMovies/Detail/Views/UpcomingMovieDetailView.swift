import UIKit

final class UpcomingMovieDetailView: UIView {
    // MARK: - Initialization
    required init() {
        super.init(frame: .zero)

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - NibOwnerLoadable extension
extension UpcomingMovieDetailView: NibOwnerLoadable { }

// MARK: - Private extension
private extension UpcomingMovieDetailView {
    func commonInit() {
        loadNibContent()
    }
}
