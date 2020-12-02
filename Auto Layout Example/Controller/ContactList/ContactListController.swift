import UIKit

class ContactListController: UITableViewController {
    private let viewModel: ContactListViewModel
    private let identifier = "TableCell"
    private let searchController = UISearchController(searchResultsController: nil)
    private var sectionListData: [EmployeesSection] {
        let isSearchBarEmpty = searchController.searchBar.text?.isEmpty ?? true
        let isFiltering = searchController.isActive && !isSearchBarEmpty
        return isFiltering ? viewModel.filteredListData : viewModel.sectionListData
    }

    private let refreshControll = UIRefreshControl()

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

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getEmployees), for: .valueChanged)
        refreshControl?.tintColor = .white

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search employee"
    }

    @objc
    private func getEmployees() {
        viewModel.getEmployees {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

        viewModel.filterEmployess(searchBar.text!)
        tableView.reloadData()
    }
}

extension ContactListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sectionListData[section].employees.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionListData.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = sectionListData[section].label

        return SectionHeaderView(label: label)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showContactDetails?(indexPath.section, indexPath.row)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let employee = sectionListData[indexPath.section].employees[indexPath.row]
        cell.textLabel?.text = employee.fullName

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
