import UIKit

class ProfilePhotoView: UIView {
    private let backgroundImage = UIImageView()
    private let profilePictureView = UIImageView()
    private let containerView = UIStackView()
    private let photoRadius: CGFloat
    private let image: UIImage

    init(photoRadius: CGFloat, image: UIImage) {
        self.photoRadius = photoRadius
        self.image = image

        super.init(frame: .zero)
        setup()
        layout()
    }

    func setup() {
        containerView.axis = .vertical
        containerView.alignment = .bottom
        containerView.distribution = .fill

        profilePictureView.image = image
        profilePictureView.layer.cornerRadius = photoRadius
        profilePictureView.clipsToBounds = true

        backgroundImage.image = image
    }

    func layout() {
        addSubview(containerView)
        containerView.pinEdgesToSuperviewEdges()

        let subContainerBottom = UIView()
        containerView.addSubview(subContainerBottom)
        subContainerBottom.pinEdgesToSuperview(edges: [.left, .bottom, .right])
        subContainerBottom.set(dimension: .height, to: photoRadius)

        containerView.addSubview(backgroundImage)
        backgroundImage.pin(edge: .bottom, to: .top, of: subContainerBottom)
        backgroundImage.pinEdgesToSuperview(edges: [.left, .right, .top])

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        backgroundImage.addSubview(blurEffectView)
        blurEffectView.pinEdgesToSuperviewEdges()

        subContainerBottom.addSubview(profilePictureView)
        profilePictureView.set(dimension: .height, to: photoRadius * 2 )
        profilePictureView.set(dimension: .width, to: photoRadius * 2)
        profilePictureView.pinEdgeToSuperview(edge: .bottom, inset: profilePictureView.frame.height / 3, relation: .equal)
        profilePictureView.align(axis: .vertical)

        containerView.bringSubviewToFront(subContainerBottom)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
