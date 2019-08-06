import class Foundation.Bundle
import class UIKit.UINib

protocol NibOwnerLoadable: NibLoadable { }

typealias NibOwnerReusable = Reusable & NibOwnerLoadable
