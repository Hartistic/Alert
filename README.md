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

<div align = "center">
<img src="Assets/example.png" width="1000" />
</div>

## Usage

- Simple Alert

```swift
let alert = AlertView(image: nil, title: "Error Occurred", subtitle: "Image failed to download")
let dismissButton = AlertButton.dismiss { _ in
    alert.dismiss()
}
alert.buttons = [dismissButton]
alert.present(on: self.view)
```

- Simple Alert + Rounded Button:

```swift
let alert = AlertView(image: nil, title: "Error Occurred", subtitle: "Image failed to download")
let dismissButton = AlertButton.dismiss { _ in
    alert.dismiss()
}
alert.buttons = [dismissButton]
alert.setButton(height: 40, cornerRadius: 20)
alert.present(on: self.view)
```

- Simple Alert + Multiple Buttons + Rounded:

```swift
let alert = AlertView(image: nil, title: "Error Occurred", subtitle: "Image failed to download")
let yesButton = AlertButton.yes { _ in
    // Do something when Yes is tapped
}
let noButton = AlertButton.no { _ in
    alert.dismiss()
}
alert.buttons = [noButton, yesButton]
alert.setButton(height: 40, cornerRadius: 20)
alert.present(on: self.view)
```

- Vertical Buttons:

```swift
alert.buttonLayout = .vertical
```

- Change Vibrancy Background Color:

```swift
alert.vibrancyColor = .red
```

- Title & Subtitle Font:
```swift
alert.titleFont = UIFont.systemFont(ofSize: 40, weight: .bold)
alert.subtitleFont = UIFont.systemFont(ofSize: 20, weight: .bold)
```

- Title & Subtitle Color:
```swift
alert.titleColor = .blue
alert.subtitleColor = .green
```
