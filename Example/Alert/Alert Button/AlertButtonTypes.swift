import UIKit

/// Contains core button types that have a high rate of resuaseability.
extension AlertButton {
    private static let dismissTitle = "Dismiss"
    private static let okayTitle = "Okay"
    private static let yesTitle = "Yes"
    private static let noTitle = "No"
    
    class func dismiss(handler: @escaping ButtonClosure) -> AlertButton {
        return AlertButton(title: Self.dismissTitle, color: .systemRed, handler: handler)
    }
    
    class func no(handler: @escaping ButtonClosure) -> AlertButton {
        return AlertButton(title: Self.noTitle, color: .systemRed, handler: handler)
    }
    
    class func okay(handler: @escaping ButtonClosure) -> AlertButton {
        return AlertButton(title: Self.okayTitle, color: .systemGreen, handler: handler)
    }
    
    class func yes(handler: @escaping ButtonClosure) -> AlertButton {
        return AlertButton(title: Self.yesTitle, color: .systemGreen, handler: handler)
    }
}
