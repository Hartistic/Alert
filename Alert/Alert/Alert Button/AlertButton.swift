import Foundation
import UIKit

public class AlertButton: UIButton {
    
    convenience init(title: String, color: UIColor, cornerRadius: CGFloat, handler: @escaping ButtonClosure) {
        self.init(frame: .zero)
        setupTitle(title)
        backgroundColor = color
        addShadow(withRadius: cornerRadius)
        targetClosure = handler
        addTargets()
        self.constrain(height: 40)
    }
    
    private func addTargets() {
        addTarget(self, action: #selector(AlertButton.closureAction), for: .touchUpInside)
        addTarget(self, action: #selector(AlertButton.touchDownAnimation), for: .touchDown)
    }
    
    private func setupTitle(_ title: String) {
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.50), for: .highlighted)
        setTitleColor(.white, for: .normal)
        setTitleShadowColor(UIColor.lightGray, for: .normal)
        titleLabel?.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func addShadow(withRadius radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.black.cgColor
    }
}

