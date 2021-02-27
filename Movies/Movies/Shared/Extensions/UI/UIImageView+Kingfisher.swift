import Foundation
import UIKit

import Kingfisher

extension UIImageView {
    func load(url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
            switch result {
            case .failure:
                self.backgroundColor = .darkGray

            default:
                break
            }
        }
    }
}
