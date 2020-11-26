import UIKit

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
        presenter.pushViewController(ContactListController(viewModel: viewModel), animated: true)
    }

    private func showDetailsScreen() {
    }
}
