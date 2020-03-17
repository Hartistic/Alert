import UIKit

public class AlertViewController: UIViewController {
    private var titleText: String?
    private var subtitleText: String?
    private var image: UIImage?
    internal var buttons: [AlertButton] = []
    internal var queueCount: Int = 0
    internal var vibrancyColor: UIColor = .clear
    internal var buttonLayout: NSLayoutConstraint.Axis = .horizontal
    internal var buttonHeight: CGFloat = 40
    internal var cornerRadius: CGFloat = 0
    internal var titleFont = UIFont.preferredFont(forTextStyle: .headline)
    internal var subtitleFont = UIFont.preferredFont(forTextStyle: .subheadline)
    internal var titleColor: UIColor = .white
    internal var titleAlignment: NSTextAlignment = .left
    internal var subtitleColor: UIColor = .white
    internal var subtitleAlignment: NSTextAlignment = .left
    internal var backgroundColor: UIColor = .clear

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(image: UIImage?, title: String?, subtitle: String?) {
        self.init()
        self.modalPresentationStyle = .overFullScreen
        self.titleText = title
        self.subtitleText = subtitle
        self.image = image
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        let alertView = AlertView(image: image, title: titleText, subtitle: subtitleText)
        alertView.buttons = buttons
        alertView.vibrancyColor = vibrancyColor
        alertView.buttonLayout = buttonLayout
        alertView.titleColor = titleColor
        alertView.subtitleColor = subtitleColor
        alertView.titleFont = titleFont
        alertView.subtitleFont = subtitleFont
        alertView.queueCount = queueCount
        alertView.titleAlignment = titleAlignment
        alertView.subtitleAlignment = subtitleAlignment
        alertView.setButton(height: buttonHeight, cornerRadius: cornerRadius)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(alertView)
        alertView.constrainCenterX()
        alertView.constrainCenterY()
        self.view.backgroundColor = backgroundColor
    }
}
