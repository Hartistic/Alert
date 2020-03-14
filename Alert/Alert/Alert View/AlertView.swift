import Foundation
import UIKit

public class AlertView: UIView {
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var subtitleLabel: UILabel?
    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var vibrancyView: UIVisualEffectView?
    @IBOutlet private var contentStackView: UIStackView?
    @IBOutlet private var titleStackView: UIStackView?
    @IBOutlet private var buttonStackView: UIStackView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    public var buttons: [AlertButton]? {
        get { buttonStackView?.arrangedSubviews as? [AlertButton] }
        set {
            guard let newValue = newValue, !newValue.isEmpty else { return }
            for value in newValue { buttonStackView?.addArrangedSubview(value) }
        }
    }
    
    public var buttonLayout: NSLayoutConstraint.Axis {
        get { buttonStackView?.axis ?? .horizontal }
        set { buttonStackView?.axis = newValue }
    }
    
    /// How the title stackview lays out.  If vertical, will center the title text under the image.
    public var titleLayout: NSLayoutConstraint.Axis {
        get { titleStackView?.axis ?? .horizontal }
        set {
            titleStackView?.axis = newValue
            if newValue == .vertical {
                self.titleLabel?.textAlignment = .center
            }
        }
    }
    
    public convenience init(image: UIImage?, title: String, subtitle: String) {
        self.init(frame: .zero)
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    public func set(image: UIImage?, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
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
    
    private func addToSubview(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.constrainLeading(to: view, margin: 40)
        self.constrainTrailing(to: view, margin: 40)
        self.constrainCenterY()
        self.constrainCenterX()
    }
    
    internal var title: String? {
        get { return titleLabel?.text }
        set { titleLabel?.text = newValue}
    }
    
    internal var titleColor: UIColor? {
        get { return titleLabel?.textColor }
        set { titleLabel?.textColor = newValue }
    }
    
    internal var titleFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    internal var subtitle: String? {
        get { return subtitleLabel?.text }
        set { subtitleLabel?.text = newValue}
    }
    
    internal var subtitleColor: UIColor? {
        get { return subtitleLabel?.textColor }
        set { subtitleLabel?.textColor = newValue }
    }
    
    internal var subtitleFont: UIFont? {
        get { return subtitleLabel?.font }
        set { subtitleLabel?.font = newValue }
    }
    
    internal var image: UIImage? {
        get { return imageView?.image }
        set { imageView?.image = newValue}
    }
    
    internal var vibrancyColor: UIColor? {
        get { return vibrancyView?.backgroundColor }
        set { vibrancyView?.backgroundColor = newValue}
    }
}


