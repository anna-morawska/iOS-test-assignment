import UIKit

class ContactListController: UITableViewController {
    private let viewModel: ContactListViewModel
    private let identifier = "TableCell"

    init(viewModel: ContactListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setup()
        viewModel.getEmployees {
            self.tableView.reloadData()
        }
    }

    private func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionListData[section].employees.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionListData.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = viewModel.sectionListData[section].label

        return SectionHeaderView(label: label)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let employee = viewModel.sectionListData[indexPath.section].employees[indexPath.row]
        cell.textLabel?.text = "\(employee.lname) \(employee.fname)"

        return cell
    }
}

extension ContactListController: NavigationBarAppearance {
    var screenTitle: String? {
        return "Employees"
    }

    var isNavigationBarHidden: Bool {
        return false
    }

    var canNavigateBack: Bool {
        return false
    }
}
