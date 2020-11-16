import UIKit

class PageCell: UICollectionViewCell {

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

    private let imageView: UIImageView  = {
        let imageView =  UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let titleTextView: UITextView = {
       let textView = UITextView()
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let topImageContainerView: UIView = {
        let topImageContainerView = UIView()

        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        return topImageContainerView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    private func setupLayout() {
        addSubview(titleTextView)
        addSubview(topImageContainerView)
        topImageContainerView.addSubview(imageView)

        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true

        imageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.8).isActive = true
        imageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.8).isActive = true

        titleTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
