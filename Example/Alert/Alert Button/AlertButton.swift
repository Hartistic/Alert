import UIKit

/// The alert button that is placed within an AlertView so that the user can take an action.
public class AlertButton: UIButton {
    
    /// Convenience Initializer.  Set the title, background color and corner radius of the button.
    /// - Parameters:
    ///     - title: (String) The title text of the button.
    ///     - color: (UIColor) The background color of the button.
    ///     - cornerRadius: (CGFloat) The corner radius of the button.
    ///     - handler: (escaping ButtonClosure) The action to take when the button is tapped.
    convenience init(title: String, color: UIColor, cornerRadius: CGFloat, handler: @escaping ButtonClosure) {
        self.init(frame: .zero)
        setupTitle(title)
        backgroundColor = color
        addShadow(withRadius: cornerRadius)
        targetClosure = handler
        addTargets()
    }
    
    /// The height of the button.
    public var height: CGFloat {
        get {
            if let heightConstraint = buttonHeightConstraint {
                return heightConstraint.constant
            }
            return self.frame.height
        }
        set {
            if buttonHeightConstraint != nil {
                buttonHeightConstraint?.constant = newValue
            } else {
                addHeightConstraint(value: newValue)
            }
        }
    }
    
    // MARK: Helpers:
    
    /// Adds the height constraint to the button so that it's height can be layed out.
    private func addHeightConstraint(value: CGFloat) {
        buttonHeightConstraint = NSLayoutConstraint(item: self, attribute: .height,
                                                    relatedBy: .equal, toItem: nil,
                                                    attribute: .notAnAttribute, multiplier: 1,
                                                    constant: value)
        buttonHeightConstraint?.isActive = true
    }
    
    private func addTargets() {
        addTarget(self, action: #selector(AlertButton.closureAction), for: .touchUpInside)
        addTarget(self, action: #selector(AlertButton.touchDownAnimation), for: .touchDown)
    }
    
    /// Sets the title of the button along with it's states and adds shadow.
    private func setupTitle(_ title: String) {
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.50), for: .highlighted)
        setTitleColor(.white, for: .normal)
        setTitleShadowColor(UIColor.lightGray, for: .normal)
        titleLabel?.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    /// Adds shadow and a corner radius to the button.
    private func addShadow(withRadius radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.black.cgColor
    }
    
    /// The height constraint placed on the button.
    private var buttonHeightConstraint: NSLayoutConstraint?
}

