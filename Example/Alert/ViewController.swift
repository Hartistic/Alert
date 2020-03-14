import UIKit

class ViewController: UIViewController {
    private static let title = "Would you like to continue?"
    private static let subtitle = "You have unsaved progress.  This progress won't be saved."
    private static let image = #imageLiteral(resourceName: "success")
    private static let buttonOneTitle = "Button One"
    private static let buttonTwoTitle = "Button Two"
    private static let buttonThreeTitle = "Button Three"

    
    @IBAction func showVerticalAlert(_ sender: UIButton) {
        let alert = AlertView(image: Self.image, title: Self.title, subtitle: Self.subtitle)
        let yesButton = AlertButton(title: "Yes", color: .systemGreen, cornerRadius: 17) { (button) in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let noButton = AlertButton(title: "No", color: .systemRed, cornerRadius: 17) { _ in
            alert.dismiss()
        }
        alert.buttonLayout = .vertical
        alert.titleLayout = .vertical
        alert.buttons = [ yesButton, noButton ]
        alert.present(on: self.view)
    }
    
    @IBAction func showHorizontalAlert(_ sender: UIButton) {
        let alert = AlertView(image: Self.image, title: Self.title, subtitle: Self.subtitle)
        let button = AlertButton(title: "Yes", color: .systemGreen, cornerRadius: 17) { (button) in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let closeButton = AlertButton(title: "No", color: .systemRed, cornerRadius: 17) { _ in
            alert.dismiss()
        }
        alert.buttons = [closeButton, button]
        alert.present(on: self.view)
    }
    
    @IBAction func showSimpleAlert(_ sender: UIButton) {
        let alert = AlertView(image: nil, title: "New Connection", subtitle: "Add Josh as your friend?")
        let yesButton = AlertButton(title: "Yes", color: .systemGreen, cornerRadius: 20) { button in
            // Do Yes Button Action.
        }
        let noButton = AlertButton(title: "No", color: .systemRed, cornerRadius: 20) { button in
            alert.dismiss()
        }
        alert.buttons = [noButton, yesButton]
        alert.present(on: self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
}

