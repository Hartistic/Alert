import Foundation
import UIKit

internal class ExampleTableViewController: UITableViewController {
    private static let title = "The image that you chose failed to download from the server."
    private static let subtitle = "Would you like to continue and submit the photo later?"
    private static let successImage = #imageLiteral(resourceName: "Checkmark")
    private static let errorImage = #imageLiteral(resourceName: "Error")
    private static let alertCellId = "alertCell"

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gradientView = GradientBackgroundView(frame: UIScreen.main.bounds)
        view.insertSubview(gradientView, at: 0)
        self.tableView.insertSubview(gradientView, at: 0)
    }

    private func showRowZeroAlert() {
        let alert = AlertViewController(image: nil, title: "Error Occurred", subtitle: "Image failed to download.")
        let dismissButton = AlertButton.dismiss(handler: nil)
        alert.buttons = [dismissButton]
        alert.backgroundColor = .black
        Alert.shared.addAlert(alert, on: self)
    }

    private func showRowOneAlert() {
        let alert = AlertViewController(image: Self.successImage, title: "Success!", subtitle: "Image successfully uploaded!.")
        let okayButton = AlertButton.okay(handler: nil)
        alert.buttons = [okayButton]
        alert.vibrancyColor = .systemGreen
        alert.cornerRadius = 20
        alert.backgroundColor = .black
        Alert.shared.addAlert(alert, on: self)
    }

    private func showRowTwoAlert() {
        let alert = AlertViewController(image: Self.errorImage, title: "Error Occurred", subtitle: "Image failed to download.")
        let retryButton = AlertButton.retry(handler: nil)
        let dismissButton = AlertButton.dismiss(handler: nil)
        alert.buttonLayout = .vertical
        alert.buttons = [retryButton, dismissButton]
        alert.titleFont = UIFont.boldSystemFont(ofSize: 28)
        alert.titleAlignment = .center
        alert.subtitleFont = UIFont.systemFont(ofSize: 20, weight: .light)
        alert.subtitleAlignment = .center
        alert.vibrancyColor = .systemRed
        alert.cornerRadius = 20
        alert.backgroundColor = .black
        Alert.shared.addAlert(alert, on: self)
    }

    private func showRowThreeAlert() {
        let alert = AlertViewController(image: Self.errorImage, title: "Error Occurred",
                                        subtitle: "Image failed to download. Would you like to continue?")
        let yesButton = AlertButton.yes(handler: nil)
        let noButton = AlertButton.no(handler: nil)
        let dismissButton = AlertButton.dismiss(handler: nil)
        dismissButton.backgroundColor = .white
        dismissButton.textColor = .black
        alert.buttonLayout = .vertical
        alert.buttons = [yesButton, noButton, dismissButton]
        alert.titleFont = UIFont.boldSystemFont(ofSize: 28)
        alert.titleAlignment = .center
        alert.subtitleFont = UIFont.systemFont(ofSize: 20, weight: .light)
        alert.subtitleAlignment = .center
        alert.vibrancyColor = .purple
        alert.cornerRadius = 12
        alert.backgroundColor = .black
        Alert.shared.addAlert(alert, on: self)
    }

    private func launchAllAlerts() {
        showRowThreeAlert()
        showRowZeroAlert()
        showRowOneAlert()
        showRowTwoAlert()
    }

    // MARK: TABLE VIEW DELEGATE AND DATASOURCE:

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.alertCellId) else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: Self.alertCellId)
        }
        switch indexPath.section {
        case 0: setup(title: "Error Alert - Basic",
                      subtitle: "Basic",
                      for: cell)
        case 1: setup(title: "Error Alert",
                      subtitle: "Image, button corner radius, and vibrancy color",
                      for: cell)
        case 2: setup(title: "Error Alert",
                      subtitle: "Image, button corner radius, vibrancy color, title & subtitle font & alignment, vertical buttons",
                      for: cell)
        case 3: setup(title: "Full Page Error",
                      subtitle: "Image, button corner radius, vibrancy color, title & subtitle font & alignment, vertical buttons",
                      for: cell)
        case 4: setup(title: "Launch All Alerts", subtitle: "4 Alerts Total Queue Test", for: cell)
        default: return cell

        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.section {
        case 0: showRowZeroAlert()
        case 1: showRowOneAlert()
        case 2: showRowTwoAlert()
        case 3: showRowThreeAlert()
        case 4: launchAllAlerts()
        default: return
        }
    }

    private func setup(title: String, subtitle: String, for cell: UITableViewCell) {
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle
    }

}
