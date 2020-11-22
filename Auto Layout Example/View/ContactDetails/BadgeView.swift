import UIKit

class BadgeView: UIView {
    public let label: String
    private let labelView = UILabel()
    private let wrapperView = UIView()

    init(label: String) {
        self.label = label

        super.init(frame: .zero)
        setup()
        layout()
    }

    private func getColor(for position: String) -> UIColor {
        switch position {
        case "IOS":
            return .blue
        case "ANDROID":
            return .green
        case "WEB":
            return .red
        case "PM":
            return .cyan
        case "TESTER":
            return .cyan
        case "SALES":
            return .green
        default:
            return .darkGray
        }
    }

    func setup() {
        labelView.setStyle(style: .subtitle)
        labelView.text = self.label
        labelView.textColor = .white

        wrapperView.backgroundColor = getColor(for: label)
        wrapperView.layer.cornerRadius = 5
        wrapperView.clipsToBounds = true
    }

    func layout() {
        addSubview(wrapperView)
        wrapperView.centerInSuperview()

        wrapperView.addSubview(labelView)
        labelView.pinEdgesToSuperview(edges: [.bottom, .top], inset: 2, relation: .equal)
        labelView.pinEdgesToSuperview(edges: [.left, .right], inset: 8, relation: .equal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
