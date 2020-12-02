import UIKit

class BadgeView: UIView {
    public let label: String
    private let labelView = UILabel()

    init(label: String) {
        self.label = label

        super.init(frame: .zero)
        setup()
        layout()
    }

    private func getColor(for position: Position.RawValue) -> UIColor {
        switch position {
        case "IOS":
            return .orange
        case "ANDROID":
            return .red
        case "WEB":
            return .yellow
        case "PM":
            return .green
        case "TESTER":
            return .tealBlue
        case "SALES":
            return .mainPink
        default:
            return .darkGray
        }
    }

    func setup() {
        labelView.setStyle(style: .subtitle)
        labelView.text = self.label
        labelView.textColor = .white

        let color = getColor(for: label)

        backgroundColor = color
        layer.cornerRadius = 5
        clipsToBounds = true
    }

    func layout() {
        addSubview(labelView)
        labelView.pinEdgesToSuperview(edges: [.bottom, .top], inset: 2, relation: .equal)
        labelView.pinEdgesToSuperview(edges: [.left, .right], inset: 8, relation: .equal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
