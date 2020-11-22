import UIKit

public extension UIButton {

    func setIcon (
        title: String,
        image: UIImage,
        contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.setTitleColor(.lightGray, for: .normal)
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit

        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
}
