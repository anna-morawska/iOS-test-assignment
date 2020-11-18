import UIKit

class ContactListView: UIView {
    public let button = UIButton(type: .system)

    init() {
        super.init(frame: .zero)
        setup()
        layout()
    }

    func setup() {
        backgroundColor = .white

        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.darkGray, for: .normal)
    }

    func layout() {
        addSubview(button)
        button.centerInSuperview()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
