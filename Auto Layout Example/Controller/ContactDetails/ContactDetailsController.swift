import UIKit

class ContactDetailsController: UIViewController {
    private let viewModel: ContactDetailsViewModel

    init(viewModel: ContactDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        let view = ContactDetailsView(employee: viewModel.employee)
        self.view = view

        bind(to: view)
    }

    private func bind(to view: ContactDetailsView) {

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
