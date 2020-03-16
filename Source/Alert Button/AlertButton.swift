import UIKit

/// The alert button that is placed within an AlertView so that the user can take an action.
public class AlertButton: UIButton {

    /// Convenience Initializer.  Set the title, background color and corner radius of the button.
    /// - Parameters:
    ///     - title: (String) The title text of the button.
    ///     - color: (UIColor) The background color of the button.
    ///     - cornerRadius: (CGFloat) The corner radius of the button.
    ///     - handler: (escaping ButtonClosure) The action to take when the button is tapped.
    convenience init(title: String, color: UIColor, cornerRadius: CGFloat? = 0, handler: @escaping ButtonClosure) {
        self.init(frame: .zero)
        setupTitle(title)
        backgroundColor = color
        self.cornerRadius = cornerRadius ?? 0
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
    }

    /// Sets the height and corner radius of the button.
    /// - Parameters:
    ///     - height: (CGFloat) The desired height of the button.
    ///     - cornerRadius: (CGFloat) The corner radius of the button.
    public func set(height: CGFloat, cornerRadius: CGFloat) {
        self.height = height
        self.cornerRadius = cornerRadius
    }

    /// Adds shadow and a corner radius to the button.
    public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }

    /// The height constraint placed on the button.
    private var buttonHeightConstraint: NSLayoutConstraint?
}
