import UIKit

class ViewController: UIViewController {
    private static let title = "The image that you chose failed to download from the server."
    private static let subtitle = "Would you like to continue and submit the photo later?"
    private static let successImage = #imageLiteral(resourceName: "Checkmark")
    private static let errorImage = #imageLiteral(resourceName: "Error")

    @IBAction func showVerticalAlert(_ sender: UIButton) {
        let alert = AlertViewController(image: Self.successImage, title: Self.title, subtitle: Self.subtitle)
        let yesButton = AlertButton.yes { _ in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let noButton = AlertButton.no { _ in
            alert.dismiss()
        }
        yesButton.backgroundColor = .blue
        alert.vibrancyColor = .green
        alert.buttonLayout = .vertical
        alert.buttons = [ yesButton, noButton ]
        alert.buttonHeight = 50
        alert.cornerRadius = 12
        alert.backgroundColor = UIColor.white.withAlphaComponent(0.60)
        Alert.shared.addAlert(alert, on: self)
    }

    @IBAction func showHorizontalAlert(_ sender: UIButton) {
        let alert = AlertViewController(image: Self.errorImage, title: Self.title, subtitle: Self.subtitle)
        let yesButton = AlertButton.yes { _ in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let noButton = AlertButton.no { _ in
            alert.dismiss()
        }
        alert.vibrancyColor = .red
        alert.titleFont = UIFont.systemFont(ofSize: 40, weight: .bold)
        alert.subtitleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        alert.buttons = [noButton, yesButton]
        alert.buttonHeight = 40
        alert.cornerRadius = 20
        Alert.shared.addAlert(alert, on: self)
    }

    @IBAction func showSimpleAlert(_ sender: UIButton) {
        let alert = AlertViewController(image: nil, title: "New Connection", subtitle: "Add Josh as your friend?")
        let yesButton = AlertButton.yes { _ in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let noButton = AlertButton.no { _ in
            alert.dismiss()
        }
        alert.buttons = [noButton, yesButton]
        Alert.shared.addAlert(alert, on: self)
    }

    @IBAction func showSimpleAlert2(_ sender: UIButton) {
        let alert = AlertViewController(image: nil, title: "Error Occurred", subtitle: "Image failed to download")
        let dismissButton = AlertButton.dismiss { _ in
            alert.dismiss()
        }
        alert.buttons = [dismissButton]
        alert.buttonHeight = 40
        alert.cornerRadius = 20
        Alert.shared.addAlert(alert, on: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

}
