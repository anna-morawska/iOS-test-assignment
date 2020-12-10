import UIKit

class PageCellView: UICollectionViewCell {
    public static let Identifier = "PageCell"

    public let imageView = UIImageView()
    public let titleLabel = UILabel()
    public let descriptionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setup()
        layout()
    }

    private func setup() {
        imageView.contentMode = .scaleAspectFit
        titleLabel.setStyle(style: .reversedColorTitle)
        descriptionLabel.setStyle(style: .description)
    }

    private func layout() {
        let topImageContainerView = UIView()

        contentView.addSubview(topImageContainerView)
        topImageContainerView.pinEdgesToSuperview(edges: [.left, .right, .top], inset: 0, relation: .equal)
        topImageContainerView.match(dimension: .height, to: self, withMultiplier: 0.5)

        topImageContainerView.addSubview(imageView)
        imageView.centerInSuperview()
        imageView.match(dimension: .height, to: contentView, withMultiplier: 0.8)
        imageView.match(dimension: .width, to: contentView, withMultiplier: 0.8)

        let bottomTextContainer = UIView()
        contentView.addSubview(bottomTextContainer)
        bottomTextContainer.pinEdgesToSuperview(edges: [.left, .bottom, .right])
        bottomTextContainer.pin(edge: .top, to:.bottom, of: topImageContainerView)

        bottomTextContainer.addSubview(titleLabel)
        bottomTextContainer.addSubview(descriptionLabel)
        titleLabel.pinEdgesToSuperview(edges: [.left, .top, .right], inset: 20)
        descriptionLabel.pinEdgesToSuperview(edges: [.left, .right], inset: 20)
        descriptionLabel.pin(edge: .top, to: .bottom, of: titleLabel, offset: 20, relation: .equal)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
