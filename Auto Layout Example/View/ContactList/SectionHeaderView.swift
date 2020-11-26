import UIKit

class SectionHeaderView: UIView {
    public let label: String
    private let wrapperView = UIView()

    init(label: String) {
        self.label = label

        super.init(frame: .zero)
        layout()
    }

    func layout() {
        let badge = BadgeView(label: self.label)
        addSubview(badge)
        badge.pinEdgesToSuperview(edges: [.left, .bottom, .top], inset: 15)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
