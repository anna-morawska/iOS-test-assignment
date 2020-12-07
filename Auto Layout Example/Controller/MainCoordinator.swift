import UIKit
import ContactsUI

public protocol Coordinator {
    var presenter: UINavigationController {get set}
    func start()
}

class MainCoordinator: Coordinator {
    var presenter: UINavigationController

    init(navigationController: UINavigationController) {
        self.presenter = navigationController
    }

    func start() {
//        showOnboarding()
        showContactList()
    }

    private func showOnboarding() {
        let viewModel = OnboardingViewModel()

        viewModel.finishOnboarding = { [weak self]  in
            self?.showContactList()
        }

        presenter.pushViewController(OnboardingViewController(viewModel: viewModel), animated: true)
    }

    private func showContactList() {
        let viewModel = ContactListViewModel()

        viewModel.showContactDetails = { [weak self] employee in
            self?.showDetailsScreen(for: employee)
        }

        presenter.pushViewController(ContactListController(viewModel: viewModel), animated: true)
    }

    private func showDetailsScreen(for employee: EnrichedEmployeeData) {
        let viewModel = ContactDetailsViewModel(employee: employee)

        viewModel.showContactApp = { [weak self] contact in
            self?.showContactApp(contact: contact)
        }

        viewModel.fetchAvatarImage(avatarNumber: employee.contactId) { (avatar) in
            DispatchQueue.main.async {
                self.presenter.pushViewController(ContactDetailsController(viewModel: viewModel, avatarImage: avatar), animated: true)
            }
        }
    }

    private func showContactApp(contact: CNContact) {
        let contactViewController = CNContactViewController(forUnknownContact: contact)
        contactViewController.allowsEditing = false
        contactViewController.allowsActions = false
        self.presenter.pushViewController(contactViewController, animated: true)
    }
}
