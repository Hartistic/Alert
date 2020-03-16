import UIKit

/// The alert view showcases the user interface elements of the alert.  It contains the buttons, labels, stack views, image view.
public class AlertView: UIView {
    private static let nibName = "AlertView"
    /// The title at the top of the Alert.
    @IBOutlet private var titleLabel: UILabel?
    /// The subtitle centered in the Alert.
    @IBOutlet private var subtitleLabel: UILabel?
    /// The imageview used to show an image next to the title label.
    @IBOutlet private var imageView: UIImageView?
    /// The visual effect view for the entire alert.
    @IBOutlet private var vibrancyView: UIVisualEffectView?
    /// The stack view which encases the title stack view, button stack view, title label, subtitle label, imageView, and buttons.
    @IBOutlet private var contentStackView: UIStackView?
    /// The top constraint of the content stack view.
    @IBOutlet private var contentStackViewTopConstraint: NSLayoutConstraint?
    /// The stack view within the content stack view which encases the Alert Buttons.
    @IBOutlet private var buttonStackView: UIStackView?
    /// The label that shows how many alerts are in the queue.
    @IBOutlet private var queueLabel: UILabel?
    /// The view that encases the queue label counter.
    @IBOutlet private var queueView: UIView?
    
    /// Standard default spacing:
    private static let marginSpacing: CGFloat = 30

    // MARK: INITIALIAZERS:
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    /// Convenience Initializer.  Set an image, title, and subtitle to your alert.
    /// - Parameters:
    ///     - image: (UIImage?) The image that should show next to the title.
    ///     -  title: (String?) The title to set at the top of the Alert.
    ///     - subtitle: (String?) The subtitle to set under the title.
    public convenience init(image: UIImage?, title: String?, subtitle: String?) {
        self.init(frame: .zero)
        if image == nil {
            imageView?.removeFromSuperview()
            contentStackViewTopConstraint?.constant = Self.marginSpacing
        } else {
            self.image = image
        }
        self.title = title
        self.subtitle = subtitle
    }
    
    // MARK: PUBLIC FUNCTIONS:
    
    /// Set an image, title, and subtitle to your alert.
    /// - Parameters:
    ///     - image: (UIImage?) The image that should show next to the title.
    ///     -  title: (String?) The title to set at the top of the Alert.
    ///     - subtitle: (String?) The subtitle to set under the title.
    public func set(image: UIImage?, title: String?, subtitle: String?) {
        if image == nil {
            imageView?.removeFromSuperview()
            contentStackViewTopConstraint?.constant = Self.marginSpacing
        } else {
            self.image = image
        }
        self.titleLabel?.text = title
        self.subtitleLabel?.text = subtitle
    }
    
    public func setButton(height: CGFloat, cornerRadius: CGFloat) {
        guard let buttons = buttons else { return }
        for button in buttons {
            button.set(height: height, cornerRadius: cornerRadius)
        }
    }
    
    // MARK: INTERNAL VARIABLES:
    
    /// Sets the queue label to the queue count.  If zero, hides the view.
    internal var queueCount: Int {
        get { Int(queueLabel?.text ?? "0") ?? 0 }
        set { queueLabel?.text = String(newValue)
            queueView?.isHidden = newValue <= 0 }
    }
    
    /// The buttons to include within the alert. Type: [AlertButton]
    internal var buttons: [AlertButton]? {
        get { buttonStackView?.arrangedSubviews as? [AlertButton] }
        set {
            guard let newValue = newValue, !newValue.isEmpty else { return }
            for value in newValue { buttonStackView?.addArrangedSubview(value) }
        }
    }
    
    /// The type of layout for your Alert Buttons:
    /// - Vertical: Up and down.
    /// - Horizontal: Side to Side.
    internal var buttonLayout: NSLayoutConstraint.Axis {
        get { buttonStackView?.axis ?? .horizontal }
        set { buttonStackView?.axis = newValue }
    }
    
    /// The title text for the Alert.
    internal var title: String? {
        get { return titleLabel?.text }
        set { titleLabel?.text = newValue}
    }
    
    /// The title text color for the Alert.
    internal var titleColor: UIColor? {
        get { return titleLabel?.textColor }
        set { titleLabel?.textColor = newValue }
    }
    
    /// The title text font for the Alert.
    internal var titleFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    /// The subtitle text for the Alert.
    internal var subtitle: String? {
        get { return subtitleLabel?.text }
        set { subtitleLabel?.text = newValue}
    }
    
    /// The subtitle text color for the Alert.
    internal var subtitleColor: UIColor? {
        get { return subtitleLabel?.textColor }
        set { subtitleLabel?.textColor = newValue }
    }
    
    /// The subtitle text font for the Alert.
    internal var subtitleFont: UIFont? {
        get { return subtitleLabel?.font }
        set { subtitleLabel?.font = newValue }
    }
    
    /// The image to set next to the title.
    internal var image: UIImage? {
        get { return imageView?.image }
        set { imageView?.image = newValue}
    }
    
    /// The background color of the UIVisualEffectView.
    internal var vibrancyColor: UIColor? {
        get { return vibrancyView?.backgroundColor }
        set { vibrancyView?.backgroundColor = newValue}
    }
    
    // MARK: PRIVATE HELPERS:
    
    /// Adds the Alertview to the superview with constraints.
    private func addToSubview(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.constrainLeading(to: view, margin: 40)
        self.constrainTrailing(to: view, margin: 40)
        self.constrainCenterY()
        self.constrainCenterX()
    }
}


