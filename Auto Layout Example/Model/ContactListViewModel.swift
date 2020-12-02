import UIKit
import Contacts

class ContactListViewModel {
    private let networking = Networking()
    private let dispatchGroup = DispatchGroup()
    internal var employees = [Employee]()
    internal var filteredEmployees = [Employee]()
    internal var showContactDetails: ((Int, Int) -> Void)?

    internal func getEmployees(completion: @escaping (() -> Void)) {
        getTallinnEmployees()
        getTartuEmployees()

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }

    internal func findMatchingContactForEmployee(employee: Employee) -> CNContact? {
        return nil
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

    internal func filterEmployess(_ filter: String) {
        filteredEmployees = employees.filter({ (employee) -> Bool in
            return employee.matches(query: filter)
        })
    }

    internal func groupEmployees(employess: [Employee]) -> [EmployeesSection] {
        let uniqueEmloyees = Array(Set(employess))

        let groups = Dictionary(grouping: uniqueEmloyees) { (employee) -> String in
            return employee.position
        }

        let sortedEmployees =  groups.map { (label, employees)  in
            return  EmployeesSection(label: label, employees: employees.sorted())
        }

        return sortedEmployees.sorted()
    }

    internal var filteredListData: [EmployeesSection] {
        return groupEmployees(employess: filteredEmployees)
    }

    internal var sectionListData: [EmployeesSection] {
        return groupEmployees(employess: employees)
    }
}
