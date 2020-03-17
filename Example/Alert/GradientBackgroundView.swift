import UIKit

class GradientBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createLayer()
    }

    private func createLayer() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        guard let gradientLayer = self.layer as? CAGradientLayer else { return }

        let yellow =  UIColor.yellow.cgColor
        let orange = UIColor.orange.cgColor
        let red = UIColor.red.cgColor

        gradientLayer.colors = [yellow, red, orange]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.bounds
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
