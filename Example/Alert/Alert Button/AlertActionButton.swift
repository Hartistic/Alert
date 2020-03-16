import UIKit

typealias ButtonClosure = (AlertButton) -> Void

class ClosureWrapper: NSObject {
    let closure: ButtonClosure
    init(_ closure: @escaping ButtonClosure) {
        self.closure = closure
    }
}

extension AlertButton {

    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }

    internal var targetClosure: ButtonClosure? {
        get { (objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper)?.closure }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func addTargetClosure(closure: @escaping ButtonClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(AlertButton.closureAction), for: .touchUpInside)
        addTarget(self, action: #selector(AlertButton.touchDownAnimation), for: .touchDown)
    }

    @objc func closureAction() {
        UIView.animate(withDuration: 0.10, delay: 0.10, animations: {
            self.transform = .identity
        })
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }

    @objc func touchDownAnimation() {
        UIView.animate(withDuration: 0.10, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
}
