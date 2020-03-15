import UIKit

class ViewController: UIViewController {
    private static let title = "The image that you chose failed to download from the server."
    private static let subtitle = "Would you like to continue and submit the photo later?"
    private static let successImage = #imageLiteral(resourceName: "Checkmark")
    private static let errorImage = #imageLiteral(resourceName: "Error")
    
    @IBAction func showVerticalAlert(_ sender: UIButton) {
        let alert = AlertView(image: Self.successImage, title: Self.title, subtitle: Self.subtitle)
        let yesButton = AlertButton.yes { _ in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let noButton = AlertButton.no { _ in
            alert.dismiss()
        }
        
        alert.buttonLayout = .vertical
        alert.buttons = [ yesButton, noButton ]
        alert.setButton(height: 40, cornerRadius: 20)
        alert.present(on: self.view)
    }
    
    @IBAction func showHorizontalAlert(_ sender: UIButton) {
        let alert = AlertView(image: Self.errorImage, title: Self.title, subtitle: Self.subtitle)
        let yesButton = AlertButton.yes { _ in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let noButton = AlertButton.no { _ in
            alert.dismiss()
        }
        
        alert.buttons = [noButton, yesButton]
        alert.setButton(height: 40, cornerRadius: 20)
        alert.present(on: self.view)
    }
    
    @IBAction func showSimpleAlert(_ sender: UIButton) {
        let alert = AlertView(image: nil, title: "New Connection", subtitle: "Add Josh as your friend?")
        let yesButton = AlertButton.yes { _ in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let noButton = AlertButton.no { _ in
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

