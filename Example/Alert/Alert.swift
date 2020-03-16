import Foundation
import UIKit

public class Alert {
    /// Shared instance of StudentManager:
    public static let shared = Alert()
    /// Prevent someone from creating another instance:
    private init() {}
    private static let alertObserverId = "Alert Manager Observer"
    
    /// Observer that detects additions and removals from the alert queue:
    public var alertObserver = Observer<Bool>(value: false)
    /// Alert controllers that are pending to be shown:
    public private(set) var pendingAlertViews: [AlertViewController] = []
    private var currentViewController: UIViewController?
    
    /// Adds an alert to the alert view queue:
    /// - Parameter alertView: (AlertView) The alert view to add to the queue.
    public func addAlert(_ alertView: AlertViewController, on viewController: UIViewController) {
        currentViewController = viewController
        DispatchQueue.main.async {
             self.pendingAlertViews.append(alertView)
             self.alertObserver.post(value: true)
         }
    }
    
    /// Tells the alert to dismiss itself and to call the next alert to show.
    /// - Parameter alertController: (UIAlertViewController) The alert view controller to dismiss.
    public func dismissAlert() {
        alertObserver.post(value: true)
    }

    internal func setupAlertChangeObserver() {
        alertObserver.bind(id: Self.alertObserverId) { _, queueHasChanged in
            // Nothing to add:
            if queueHasChanged, self.pendingCount <= 0 { return }
            
            if self.currentViewController?.children.count == 1 {
                return
            }
            
            // Add a new alert controller to the very top view controller:
            guard self.pendingCount > 0, let newAlert = self.topAlert else { return }
            self.showAlert(newAlert)
        }
    }
    
    /// The current count of pending alert views.
    public var pendingCount: Int {
        self.pendingAlertViews.count
    }
    
    /// True if the view has alert views in the queue waiting to be shown.
    public var hasPendingAlerts: Bool {
        pendingCount == 0
    }

    /// Adds alert to the alert view queue:
    /// - Parameters:
    ///     - image: (UIImage?) The image to show on the alert, if any.
    ///     - title: (String?) The title for the alert.
    ///     - subtitle: (String) The message body of the alert.
    ///     - buttons: ([AlertButton)] The collection of action buttons to pass to the alert.
    /// - Note: Runs on the main thread.
    public func addAlert(image: UIImage?, title: String? = nil, subtitle: String? = nil, buttons: [AlertButton],
                         on viewController: UIViewController) {
        DispatchQueue.main.async {
            let alert = AlertViewController(image: image, title: title, subtitle: subtitle)
            alert.buttons = buttons
            self.addAlert(alert, on: viewController)
        }
    }
    
    
    /// - Note: Shows an alert to the user.
    /// - Parameter alert: (AlertView) The alert controller that will be show to the user.
    /// - Note: Runs on the main thread.
    private func showAlert(_ alertView: AlertViewController, animated: Bool = true, delay: Double = 0) {
        guard let currentViewController = currentViewController else { return }
        DispatchQueue.main.async {
            /// Do not show Alerts on the Launch Screen View Controller:
            if delay > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    if self.hasPendingAlerts {
                         alertView.queueCount = self.pendingCount
                     }
                    currentViewController.present(alertView, animated: true, completion: nil)
                })
                return
            }
            
            if self.hasPendingAlerts {
                alertView.queueCount = self.pendingCount
            }
            currentViewController.present(alertView, animated: true, completion: nil)
        }
    }
    
    /// - Returns: (AlertView?) The first alert controller in line to be shown next, grabbing the alert from pendingAlertViews index 0.
    private var topAlert: AlertViewController? {
        guard let topAlert = pendingAlertViews.first else { return nil }
        pendingAlertViews.remove(at: 0)
        return topAlert
    }
}
