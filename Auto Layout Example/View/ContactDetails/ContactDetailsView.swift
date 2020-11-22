import UIKit

class ContactDetailsView: UIView {
    private let employee: Employee
    private let pictureRadius = CGFloat(100)

    private let nameLabel = UILabel()
    private let bioTitleLabel = UILabel()
    private let bioLabel = UILabel()
    private let projectsTitleLabel = UILabel()
    private let projectListLabel = UILabel()
    private let emailButton = UIButton()
    private let locationButton = UIButton()
    private let phoneButton = UIButton()

    private let badge: BadgeView
    private let image: UIImage

    init(employee: Employee) {
        self.employee = employee

        badge = BadgeView(label: employee.position)
        image = UIImage(named: employee.image!)!

        super.init(frame: .zero)
        setup()
        layout()
    }

    func setup() {
        backgroundColor = .white

        nameLabel.setStyle(style: .title)
        nameLabel.text = "\(employee.fname) \(employee.lname)"

        emailButton.setIcon(
            title: "anna.morawska@mooncascade.com",
            image: UIImage(named: "EmailIcon")!,
            contentPadding: .zero,
            imageTitlePadding: 15)

        locationButton.setIcon(
            title: "TALLINN",
            image: UIImage(named: "MapPinIcon")!,
            contentPadding: .zero,
            imageTitlePadding: 15)

        phoneButton.setIcon(
            title: "+48 730 493 123",
            image: UIImage(named: "PhoneIcon")!,
            contentPadding: .zero,
            imageTitlePadding: 15)

        bioTitleLabel.setStyle(style: .subtitle)
        bioTitleLabel.text = "CONTACT DETAILS:"
        bioTitleLabel.textAlignment = .left

        projectsTitleLabel.setStyle(style: .subtitle)
        projectsTitleLabel.text = "PROJECTS:"
        projectsTitleLabel.textAlignment = .left

        projectListLabel.setStyle(style: .description)
        projectListLabel.text =  employee.projects?.joined(separator: " • ")
        projectListLabel.textAlignment = .left

        bioLabel.setStyle(style: .description)
        bioLabel.text = "Amet consectetur adipiscing elit pellentesque habitant morbi tristiqu, pellentesque habitant morbi tristique"
        bioLabel.textAlignment = .center
    }

    func layout() {
        let profilePhotoView = ProfilePhotoView(photoRadius: pictureRadius, image: image)
        addSubview(profilePhotoView)
        profilePhotoView.pinEdgesToSuperview(edges: [.left, .right, .top])
        profilePhotoView.match(dimension: .height, to: self, withMultiplier: 0.4)

        let contentStackView = UIStackView(arrangedSubviews:
                                        [bioTitleLabel,
                                         emailButton,
                                         phoneButton,
                                         locationButton,
                                         projectsTitleLabel,
                                         projectListLabel])
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.distribution = .fillEqually
        contentStackView.set(dimension: .height, to: 250)

        let contentContainer = UIStackView(arrangedSubviews:
                                            [nameLabel,
                                             badge,
                                             bioLabel,
                                             contentStackView ])

        addSubview(contentContainer)
        contentContainer.axis = .vertical
        contentContainer.alignment = .center
        contentContainer.distribution = .fill
        contentContainer.spacing = 30

        contentContainer.pinEdgesToSuperview(edges: [.left, .right], inset: 20)
        contentContainer.pin(edge: .top, to: .bottom, of: profilePhotoView, offset: 30, relation: .equal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
