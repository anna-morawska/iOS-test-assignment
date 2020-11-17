import UIKit

class PageCellView: UICollectionViewCell {

    var page: Page? {
        didSet {
            guard let unwrapperdPage = page else { return }
            imageView.image = UIImage(named: unwrapperdPage.imageName)

            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
            ]

            let descriptionAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
            ]

            let attributedText = NSMutableAttributedString(string: unwrapperdPage.headerText, attributes: titleAttributes)
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrapperdPage.description)", attributes: descriptionAttributes))

            titleTextView.attributedText = attributedText
            titleTextView.textAlignment = .center
        }
    }

    private let topImageContainerView = UIView()
    private let imageView = UIImageView()
    private let titleTextView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        layout()
    }

    private func setup() {
        imageView.contentMode = .scaleAspectFit

        titleTextView.isEditable = false
    }

    private func layout() {
        addSubview(topImageContainerView)
        topImageContainerView.pinEdgesToSuperview(edges: [.left, .right, .top], inset: 0, relation: .equal)
        topImageContainerView.match(dimension: .height, to: self, withMultiplier: 0.5)

        topImageContainerView.addSubview(imageView)
        imageView.centerInSuperview()
        imageView.match(dimension: .height, to: self, withMultiplier: 0.8)
        imageView.match(dimension: .width, to: self, withMultiplier: 0.8)

        addSubview(titleTextView)
        titleTextView.pinEdgesToSuperview(edges: [.left, .right, .bottom], inset: 20)
        titleTextView.pin(edge: .top, to: .bottom, of: topImageContainerView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
