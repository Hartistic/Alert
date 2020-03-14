//
//  ViewController.swift
//  Alert
//
//  Created by Joshua Hart on 3/12/20.
//  Copyright © 2020 Joshua Hart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private static let title = "Do You Want Pizza?"
    private static let subtitle = "There are 4 pizzas down the road from us, would you like some."
    private static let image = #imageLiteral(resourceName: "success")
    private static let buttonOneTitle = "Button One"
    private static let buttonTwoTitle = "Button Two"
    private static let buttonThreeTitle = "Button Three"

    
    @IBAction func showVerticalAlert(_ sender: UIButton) {
        let alert = AlertView(image: Self.image, title: Self.title, subtitle: Self.subtitle)
        let button = AlertButton(title: "Amanda", color: .blue, cornerRadius: 20) { (button) in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let closeButton = AlertButton(title: "Dismiss", color: .red, cornerRadius: 20) { _ in
            alert.dismiss()
        }
        alert.buttonLayout = .vertical
        alert.titleLayout = .vertical
        alert.buttons = [closeButton, button]
        alert.present(on: self.view)
    }
    
    @IBAction func showHorizontalAlert(_ sender: UIButton) {
        let alert = AlertView(image: Self.image, title: Self.title, subtitle: Self.subtitle)
        let button = AlertButton(title: "Amanda", color: .blue, cornerRadius: 20) { (button) in
            self.view.backgroundColor = self.view.backgroundColor == .red ? .green : .red
        }
        let closeButton = AlertButton(title: "Dismiss", color: .red, cornerRadius: 20) { _ in
            alert.dismiss()
        }
        alert.buttons = [closeButton, button]
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

