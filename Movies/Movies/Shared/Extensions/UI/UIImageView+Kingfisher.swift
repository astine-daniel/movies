import Foundation
import UIKit

import Kingfisher

extension UIImageView {
    func load(url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
