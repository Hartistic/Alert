import UIKit

public class AlertViewController: UIViewController {
    @IBOutlet private var visualEffectView: UIVisualEffectView?
    private var titleText: String?
    private var subtitleText: String?
    private var image: UIImage?
    private var alertStyle: AlertStyle = .alert
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
    internal var alertView: AlertView?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(image: UIImage?, title: String?, subtitle: String?, style: AlertStyle = .alert) {
        self.init()
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        self.titleText = title
        self.subtitleText = subtitle
        self.image = image
        self.alertStyle = style
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        view.backgroundColor = .clear
        setupAlertView()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.70, initialSpringVelocity: 0, options: [.curveLinear, .preferredFramesPerSecond60], animations: {
            self.alertView?.transform = .identity
        })
    }

    private func setupAlertView() {
        alertView = AlertView(image: image, title: titleText, subtitle: subtitleText)
        guard let alertView = alertView else { return }
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
        self.visualEffectView?.contentView.addSubview(alertView)
        setupAlertConstraints(forAlertView: alertView)
    }

    private func setupAlertConstraints(forAlertView alertView: AlertView) {
        switch alertStyle {
        case .alert:
            setupAlertStyle(forAlertView: alertView)

        case .actionSheet:
            setupActionSheetStyle(forAlertView: alertView)
        }
    }

    private func setupActionSheetStyle(forAlertView alertView: AlertView) {
        alertView.widthConstraint?.isActive = false
        alertView.constrainLeading(margin: 16)
        alertView.constrainTrailing(margin: 16)
        alertView.constrainBottom(margin: 40)
        actionSheetTranformAnimation(alertView)
        alertView.buttonLayout = .vertical
        alertView.titleAlignment = .center
        alertView.subtitleAlignment = .center
    }

    private func setupAlertStyle(forAlertView alertView: AlertView) {
        alertView.constrainCenterX()
        alertView.constrainCenterY()
        alertTransform(alertView)
    }

    private func actionSheetTranformAnimation(_ alertView: AlertView) {
        alertView.transform = alertView.transform.translatedBy(x: 0, y: 800)
    }

    private func alertTransform(_ alertView: AlertView) {
        let scaled = alertView.transform.scaledBy(x: 0, y: 0)
        let moved = alertView.transform.translatedBy(x: 0, y: 800)
        alertView.transform = scaled.concatenating(moved)
    }
}
