import UIKit

extension UIView {

    func prepareAndAddSubview(_ subview: UIView) {
        subview.autoresizingMask = UIView.AutoresizingMask()
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }

    /// attaches all sides of the receiver to its parent view
    func constrainAll(margin: CGFloat = 0.0) {
        let view = superview
        constrainTop(to: view, margin: margin)
        constrainBottom(to: view, margin: margin)
        constrainLeading(to: view, margin: margin)
        constrainTrailing(to: view, margin: margin)
    }

    /// Constrains the view to the top layout guide with a zero margin.
    func constrainToTopLayoutGuide() {
        guard let view = superview else {
            assertionFailure(String(format: "%@ doesn't have a superview!", self.debugDescription))
            return
        }
        NSLayoutConstraint.activate([ topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor) ])
    }

    /// attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
    /// if view is not provided, the current view's super view is used
    @discardableResult
    func constrainTop(to: UIView? = nil,
                      margin: CGFloat = 0.0,
                      relatedBy: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let view = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .top, relatedBy: relatedBy,
                                            toItem: view,
                                            attribute: isSuperview ? .top : .bottom,
                                            multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        return constraint
    }

    /// attaches the bottom of the current view to the given view
    @discardableResult
    func constrainBottom(to: UIView? = nil,
                         margin: CGFloat = 0.0,
                         relatedBy: NSLayoutConstraint.Relation = .equal,
                         priority: UILayoutPriority? = .defaultHigh) -> NSLayoutConstraint {

        let view = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom,
                                            relatedBy: relatedBy, toItem: view,
                                            attribute: isSuperview ? .bottom : .top, multiplier: 1.0,
                                            constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)

        return constraint
    }

    /// attaches the bottom of the current view to the given view's bottom
    @discardableResult
    func constrainBottomToBottom(view: UIView,
                                 margin: CGFloat = 0.0,
                                 relatedBy: NSLayoutConstraint.Relation = .equal,
                                 priority: UILayoutPriority? = .defaultHigh) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint(item: self, attribute: .bottom,
                                            relatedBy: relatedBy, toItem: view,
                                            attribute: .bottom, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)

        return constraint
    }

    /// attaches the leading edge of the current view to the given view
    @discardableResult
    func constrainLeading(to: UIView? = nil,
                          margin: CGFloat = 0.0,
                          relatedBy: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let view = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relatedBy,
                                            toItem: view,
                                            attribute: isSuperview ? .leading : .trailing,
                                            multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        return constraint
    }

    /// attaches the trailing edge of the current view to the given view
    @discardableResult
    func constrainTrailing(to: UIView? = nil,
                           margin: CGFloat = 0.0,
                           relatedBy: NSLayoutConstraint.Relation = .equal,
                           priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let view = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relatedBy,
                                            toItem: view,
                                            attribute: isSuperview ? .trailing : .leading,
                                            multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }

    /// Center's the view.
    @discardableResult
    func constrainCenterX(to: UIView? = nil,
                          margin: CGFloat = 0.0,
                          relatedBy: NSLayoutConstraint.Relation = .equal,
                          priority: UILayoutPriority? = .defaultHigh) -> NSLayoutConstraint {
        let view = to ?? superview
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relatedBy,
                                            toItem: view,
                                            attribute: .centerX,
                                            multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }

    /// Center's the view.
    @discardableResult
    func constrainCenterY(to: UIView? = nil,
                          margin: CGFloat = 0.0,
                          relatedBy: NSLayoutConstraint.Relation = .equal,
                          priority: UILayoutPriority? = .defaultHigh) -> NSLayoutConstraint {
        let view = to ?? superview
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relatedBy,
                                            toItem: view,
                                            attribute: .centerY,
                                            multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        return constraint
    }

    func constrain(height: CGFloat, priority: UILayoutPriority? = UILayoutPriority.defaultHigh) {
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: height).isActive = true
    }

    func constrain(width: CGFloat) {
        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: width).isActive = true
    }

    @discardableResult
    func fromNib<T: UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self))
            .loadNibNamed(String(describing: type(of: self)),
                          owner: self,
                          options: nil)?.first as? T else {
                            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.constrainAll()
        return contentView
    }
}
