import UIKit

open class CardCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private final weak var _shadowLayer: CAShapeLayer?

    final var cornerRadius: CGFloat = 14.0 {
        didSet {
            cornerRadiusDidChange()
        }
    }

    final var shadow = Shadow() {
        didSet {
            shadowAttributesDidChange()
        }
    }

    override open var backgroundColor: UIColor? {
        didSet {
            backgroundColorDidChange()
        }
    }

    // MARK: - Nib loading life cycle
    override open func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = backgroundColor
        updateCornerRadius()
    }

    // MARK: - Laying out subviews
    override open func layoutSubviews() {
        super.layoutSubviews()

        if _shadowLayer == nil {
            let shadowLayer = createShadowLayer()
            layer.insertSublayer(shadowLayer, at: 0)

            _shadowLayer = shadowLayer

            updateShadowCornerRadius()
        }

        updateShadowPath()
    }
}

// MARK: - Private extension
private extension CardCollectionViewCell {
    final func createShadowLayer() -> CAShapeLayer {
        let shadowLayer = CAShapeLayer()

        shadowLayer.fillColor = backgroundColor.orDefault(.white).cgColor
        shadowLayer.shadowColor = shadow.color.cgColor
        shadowLayer.shadowRadius = shadow.radius
        shadowLayer.shadowOpacity = shadow.opacity
        shadowLayer.shadowOffset = shadow.offset

        return shadowLayer
    }

    final func updateCornerRadius() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
    }

    final func updateShadowCornerRadius() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }

    final func updateShadowPath() {
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        _shadowLayer?.shadowPath = path.cgPath
        _shadowLayer?.path = path.cgPath
    }

    final func updateShadowAttributes() {
        _shadowLayer?.shadowColor = shadow.color.cgColor
        _shadowLayer?.shadowRadius = shadow.radius
        _shadowLayer?.shadowOpacity = shadow.opacity
        _shadowLayer?.shadowOffset = shadow.offset
    }

    final func backgroundColorDidChange() {
        contentView.backgroundColor = backgroundColor
        _shadowLayer?.fillColor = backgroundColor.orDefault(.white).cgColor
    }

    final func cornerRadiusDidChange() {
        updateCornerRadius()
        updateShadowCornerRadius()
        updateShadowPath()
    }

    final func shadowAttributesDidChange() {
        updateShadowAttributes()
    }
}

// MARK: - Shadow nested type
extension CardCollectionViewCell {
    struct Shadow {
        var color: UIColor = .black
        var radius: CGFloat = 20.0
        var opacity: Float = 0.28
        var offset: CGSize = .zero
    }
}
