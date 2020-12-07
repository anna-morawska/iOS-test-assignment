import UIKit
import Contacts

class ContactDetailsController: UIViewController {
    private let viewModel: ContactDetailsViewModel
    private let avatarImage: UIImage?

    init(viewModel: ContactDetailsViewModel, avatarImage: UIImage?) {
        self.viewModel = viewModel
        self.avatarImage = avatarImage
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        let view = ContactDetailsView(employee: viewModel.employee, avatarImage: avatarImage)
        self.view = view

        bind(to: view)
    }

    private func bind(to view: ContactDetailsView) {
        view.showContactDetailsButton.addTarget(
            self,
            action: #selector(showContactDetailsPressed(sender:)),
            for: .touchUpInside
        )
    }

    @objc
    func showContactDetailsPressed(sender: UIButton) {
        if let contact = viewModel.employee.contact {
            viewModel.showContactApp?(contact)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactDetailsController: NavigationBarAppearance {
    var screenTitle: String? {
        return nil
    }

    var isNavigationBarHidden: Bool {
        return false
    }

    var canNavigateBack: Bool {
        return true
    }
}
