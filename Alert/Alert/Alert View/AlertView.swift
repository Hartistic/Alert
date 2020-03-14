import UIKit

/// The alert view showcases the user interface elements of the alert.  It contains the buttons, labels, stack views, image view.
public class AlertView: UIView {
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
    /// The stack view within the content stack view  which encases the image view and the title label.
    @IBOutlet private var titleStackView: UIStackView?
    /// The stack view within the content stack view which encases the Alert Buttons.
    @IBOutlet private var buttonStackView: UIStackView?
    
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
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    /// Set an image, title, and subtitle to your alert.
    /// - Parameters:
    ///     - image: (UIImage?) The image that should show next to the title.
    ///     -  title: (String?) The title to set at the top of the Alert.
    ///     - subtitle: (String?) The subtitle to set under the title.
    public func set(image: UIImage?, title: String?, subtitle: String?) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    /// Present/Show the alert onto a view.  The view will center itself within the view you designate.
    /// - Parameters:
    ///     - view: (UIView) The view that will hold the Alert.
    ///     - animated: (Bool) Defaults to true.  If false, the alert will not be animated onto the screen.
    public func present(on view: UIView, animated: Bool = true) {
        self.alpha = 0
        addToSubview(view)
        if animated {
            self.transform = CGAffineTransform(translationX: 0, y: view.bounds.maxY)
            UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 0.61,
                           initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                            self.alpha = 1.0
                            self.transform = .identity
                            view.layoutIfNeeded()
            })
        }
    }
    
    /// Dismiss the alert from a view.  The Alert's superview must be available in order to dismiss.
    /// - Parameter animated: (Bool) Defaults to true.  If false, the alert will not animate off the screen..
    public func dismiss(animated: Bool = true) {
        guard let view = self.superview else { return }
        if animated {
            UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 0.61,
                           initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
                            self.alpha = 1.0
                            self.transform = CGAffineTransform(translationX: 0, y: view.bounds.maxY)
                            view.layoutIfNeeded()
            }, completion: { _ in
                self.removeFromSuperview()
            })
        }
    }
    
    /// The buttons to include within the alert. Type: [AlertButton]
    public var buttons: [AlertButton]? {
        get { buttonStackView?.arrangedSubviews as? [AlertButton] }
        set {
            guard let newValue = newValue, !newValue.isEmpty else { return }
            for value in newValue { buttonStackView?.addArrangedSubview(value) }
        }
    }
    
    /// The type of layout for your Alert Buttons:
    /// - Vertical: Up and down.
    /// - Horizontal: Side to Side.
    public var buttonLayout: NSLayoutConstraint.Axis {
        get { buttonStackView?.axis ?? .horizontal }
        set { buttonStackView?.axis = newValue }
    }
    
    /// The type of layout for the title, which includes an imageview and a label.
    /// The type of layout for your Alert Buttons:
    /// - Vertical: Up and down. Will center the title text under the image.
    /// - Horizontal: Side to Side.
    public var titleLayout: NSLayoutConstraint.Axis {
        get { titleStackView?.axis ?? .horizontal }
        set {
            titleStackView?.axis = newValue
            if newValue == .vertical {
                self.titleLabel?.textAlignment = .center
            }
        }
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
    
    // MARK: HELPERS:
    
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


