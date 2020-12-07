import UIKit

class ContactDetailsView: UIView {
    public let showContactDetailsButton = UIButton()
    private let employee: EnrichedEmployeeData
    private let image: UIImage
    private let pictureRadius = CGFloat(100)

    private let nameLabel = UILabel()
    private let bioTitleLabel = UILabel()
    private let bioLabel = UILabel()
    private let projectsTitleLabel = UILabel()
    private let projectListLabel = UILabel()
    private let emailButton = UIButton()
    private let locationButton = UIButton()
    private let phoneButton = UIButton()

    init(employee: EnrichedEmployeeData, avatarImage: UIImage?) {
        self.employee = employee
        self.image = avatarImage ?? UIImage(named: "Avatar")!

        super.init(frame: .zero)
        setup()
        layout()
    }

    func setup() {
        backgroundColor = .white

        nameLabel.setStyle(style: .title)
        nameLabel.text = employee.employeeData.fullName

        emailButton.setIcon(
            title: employee.employeeData.contact_details.email,
            image: UIImage(named: "EmailIcon")!,
            contentPadding: .zero,
            imageTitlePadding: 15)

        locationButton.setIcon(
            title: employee.location.rawValue,
            image: UIImage(named: "MapPinIcon")!,
            contentPadding: .zero,
            imageTitlePadding: 15)

        phoneButton.setIcon(
            title: employee.employeeData.contact_details.phone ?? "",
            image: UIImage(named: "PhoneIcon")!,
            contentPadding: .zero,
            imageTitlePadding: 15)
        phoneButton.isHidden = employee.employeeData.contact_details.phone?.isEmpty ?? true

        showContactDetailsButton.setIcon(
            title: "Address Book",
            image: UIImage(named: "ContactBookIcon")!,
            contentPadding: .zero,
            imageTitlePadding: 15)

        showContactDetailsButton.isHidden = employee.contact == nil

        bioTitleLabel.setStyle(style: .subtitle)
        bioTitleLabel.text = "CONTACT DETAILS:"
        bioTitleLabel.textAlignment = .left

        projectsTitleLabel.setStyle(style: .subtitle)
        projectsTitleLabel.text = "PROJECTS:"
        projectsTitleLabel.textAlignment = .left
        projectsTitleLabel.isHidden = employee.employeeData.projects?.isEmpty ?? true

        projectListLabel.setStyle(style: .description)
        projectListLabel.text =  employee.employeeData.projects?.joined(separator: " • ")
        projectListLabel.textAlignment = .left
        projectListLabel.isHidden = employee.employeeData.projects?.isEmpty ?? true

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
                                         showContactDetailsButton,
                                         emailButton,
                                         phoneButton,
                                         locationButton,
                                         projectsTitleLabel,
                                         projectListLabel])

        let contentContainer = UIStackView(arrangedSubviews:
                                            [nameLabel,
                                             BadgeView(label: employee.employeeData.position),
                                             bioLabel,
                                             contentStackView ])

        addSubview(contentContainer)
        contentContainer.axis = .vertical
        contentContainer.alignment = .center
        contentContainer.distribution = .fill
        contentContainer.spacing = 20

        contentStackView.pinEdgesToSuperview(edges: [.left, .right], inset: 10)
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.distribution = .fill
        contentStackView.spacing = 15

        contentContainer.pinEdgesToSuperview(edges: [.left, .right], inset: 20, relation: .equal)
        contentContainer.pin(edge: .top, to: .bottom, of: profilePhotoView, offset: 30, relation: .equal)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
