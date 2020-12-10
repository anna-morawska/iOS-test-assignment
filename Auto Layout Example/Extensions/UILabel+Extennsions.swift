import UIKit

public extension UILabel {
    enum LabelStyle {
        case title, subtitle, description, reversedColorTitle
    }

    func setStyle(style: LabelStyle) {
        switch style {
        case .title:
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
            self.textColor = UIColor.label
            self.font = .systemFont(ofSize: 22, weight: .bold)
            self.textAlignment = .center

        case .reversedColorTitle:
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
            self.textColor = .customBlack
            self.font = .systemFont(ofSize: 22, weight: .bold)
            self.textAlignment = .center

        case .subtitle:
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
            self.textColor = .gray
            self.font = .systemFont(ofSize: 14, weight: .bold)
            self.textAlignment = .center

        case .description:
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
            self.textColor = .gray
            self.font = .systemFont(ofSize: 14, weight: .light)
            self.textAlignment = .center
        default:
            fatalError("Only title, subtitle and text styles are supported")
        }
    }
}
