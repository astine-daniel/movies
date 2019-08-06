import class UIKit.UICollectionReusableView
import class UIKit.UICollectionView
import class UIKit.UICollectionViewCell

extension UICollectionView {
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: NibReusable {
            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: NibReusable {
            self.register(
                supplementaryViewType.nib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }
}
