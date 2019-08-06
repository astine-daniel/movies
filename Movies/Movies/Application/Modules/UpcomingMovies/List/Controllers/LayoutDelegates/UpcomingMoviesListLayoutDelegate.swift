import Foundation
import UIKit

final class UpcomingMoviesListLayoutDelegate: NSObject {
    // MARK: - Properties
    private let margin = 16.0
    private let preferredItemSize = CGSize(width: 324.0, height: 460.0)

    var didSelectItem = Delegated<IndexPath, Void>()

    // MARK: - Methods
    func itemsPerRow(for size: CGSize) -> Int {
        return itemsPerRow(rowWidth: maxWidth(size.width, with: margin),
                           itemWidth: itemSize(in: size).width)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout extension
extension UpcomingMoviesListLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize(in: collectionView.bounds.size)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let value = CGFloat(margin)

        return UIEdgeInsets(top: value,
                            left: value,
                            bottom: value,
                            right: value)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(margin)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(margin)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem.call(indexPath)
    }
}

// MARK: - Private extension
private extension UpcomingMoviesListLayoutDelegate {
    func itemSize(in collectionSize: CGSize) -> CGSize {
        var width = preferredItemSize.width

        let maxWidthWithMargin = maxWidth(collectionSize.width, with: margin)
        guard maxWidthWithMargin > width else {
            width = maxWidthWithMargin
            return CGSize(width: width, height: preferredItemSize.height)
        }

        let numberOfItems = itemsPerRow(rowWidth: maxWidthWithMargin, itemWidth: width)
        guard numberOfItems > 1 else {
            return CGSize(width: maxWidthWithMargin, height: preferredItemSize.height)
        }

        let interitemSpacing = totalInteritemSpacing(numberOfItems: numberOfItems)
        let sumOfItemsWidth = totalWidthOfItems(numberOfItems: numberOfItems, itemWidth: width)
        let diff = maxWidthWithMargin - (sumOfItemsWidth - interitemSpacing)

        guard diff == 0 else {
            width += (diff.magnitude / CGFloat(numberOfItems - 1))
            return CGSize(width: width, height: preferredItemSize.height)
        }

        return preferredItemSize
    }

    func maxWidth(_ width: CGFloat, with margin: Double) -> CGFloat {
        return CGFloat(Double(width) - (margin * 2.0))
    }

    func itemsPerRow(rowWidth: CGFloat, itemWidth: CGFloat) -> Int {
        return Int((rowWidth / itemWidth).rounded(.towardZero))
    }

    func totalInteritemSpacing(numberOfItems: Int) -> CGFloat {
        return CGFloat(margin) * CGFloat(numberOfItems - 1)
    }

    func totalWidthOfItems(numberOfItems: Int, itemWidth: CGFloat) -> CGFloat {
        return itemWidth * CGFloat(numberOfItems)
    }
}
