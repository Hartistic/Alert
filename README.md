<div align = "center">
<img src="Assets/Logo.png" width="700" />
</div>

<p align="center">
<img src="https://img.shields.io/badge/Swift-5%2B-brightgreen.svg" alt="Swift 5.0+"/>
<img src="https://img.shields.io/badge/platform-iOS-brightgreen.svg" alt="Platform: iOS"/>
<img src="https://img.shields.io/badge/Xcode-11%2B-brightgreen.svg" alt="XCode 11+"/>
<img src="https://img.shields.io/badge/iOS-13%2B-brightgreen.svg" alt="iOS 13"/>
<img src="https://img.shields.io/badge/licence-MIT-lightgray.svg" alt="Licence MIT"/>
</a>
</p>

# Alert

Alert is a customizable alert that acts like the native UIAlertController.  
Alert's layout, styling, and sizing is easy to change.
The main goal of Alert is to eventually create an alert queue, that instead of canceling
queued alerts (like UIAlertController does) will show the next one when the first alert is dismissed.

## Usage

- New Alert

```swift
let alert = AlertView(image: nil, title: "New Connection", subtitle: "Add Josh as your friend?")
let yesButton = AlertButton(title: "Yes", color: .systemGreen, cornerRadius: 20) { button in
    // Do Yes Button Action.
}
let noButton = AlertButton(title: "No", color: .systemRed, cornerRadius: 20) { button in
    alert.dismiss()
}
alert.buttons = [noButton, yesButton]
alert.present(on: self.view)
```

<div align = "center">
<img src="Assets/example.png" width="1000" />
</div>
