import UIKit

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
