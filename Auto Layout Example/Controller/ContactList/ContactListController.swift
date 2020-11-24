import UIKit

class ContactListController: UITableViewController {
    private let viewModel: ContactListViewModel

    init(viewModel: ContactListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        let view = UITableView()
        self.view = view
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

extension ContactListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employees.count
    }

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: <#T##IndexPath#>)
//    }
}

extension ContactListController: NavigationBarAppearance {
    var isNavigationBarHidden: Bool {
        return false
    }

    var canNavigateBack: Bool {
        return false
    }
}
