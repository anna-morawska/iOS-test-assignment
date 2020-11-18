import UIKit

class ContactListController: UIViewController {
    private let viewModel = ContactListViewModel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        let view = ContactListView()
        self.view = view

        setup()
        bind(to: view)
    }

    private func setup() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    private func bind(to view: ContactListView) {

        view.button.setTitle(viewModel.buttonLabel, for: .normal)
        view.button.restorationIdentifier = viewModel.buttonId
        view.button.addTarget(
            self,
            action: #selector(fetchData(sender:)),
            for: .touchUpInside
        )
    }

    @objc
    private func fetchData(sender: UIButton) {
        viewModel.getTallinnEmployees()
        viewModel.getTallinnEmployees()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
