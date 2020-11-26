import UIKit

class ContactListViewModel {
    private let networking = Networking()
    private let dispatchGroup = DispatchGroup()
    internal var employees = [Employee]()
    internal var showContactDetails: (() -> Void)?

    internal func getEmployees(completion: @escaping (() -> Void)) {
        getTallinnEmployees()
        getTartuEmployees()

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }

    internal func getTallinnEmployees() {
        dispatchGroup.enter()
        networking.performNetworkTask(endpoint: TallinnJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            self?.employees.append(contentsOf: response.employees)
            self?.dispatchGroup.leave()
        }
    }

    internal func getTartuEmployees() {
        dispatchGroup.enter()
        networking.performNetworkTask(endpoint: TartuJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            self?.employees.append(contentsOf: response.employees)
            self?.dispatchGroup.leave()
        }
    }

    internal var sectionListData: [EmployeesSection] {
        let uniqueEmloyees = Array(Set(employees))

        let groups = Dictionary(grouping: uniqueEmloyees) { (employee) -> String in
            return employee.position
        }

        let sortedEmployees =  groups.map { (label, employees)  in
            return  EmployeesSection(label: label, employees: employees.sorted())
        }

        return sortedEmployees.sorted()
    }
}
