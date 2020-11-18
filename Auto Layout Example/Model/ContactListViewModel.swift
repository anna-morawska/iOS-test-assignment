import UIKit

class ContactListViewModel {
    internal let buttonLabel = "FETCH"
    internal let buttonId = "fetchButton"

    private let networking = Networking()

    internal var tallinnEmployees: [Employee] = []
    internal var tartuEmployees: [Employee] = []

    internal func getTallinnEmployees() {
        networking.performNetworkTask(endpoint: TallinnJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            self?.tallinnEmployees = response.employees
            print(response.employees)
        }
    }

    internal func getTartuEmployees() {
        networking.performNetworkTask(endpoint: TartuJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            self?.tartuEmployees = response.employees
            print(response.employees)
        }
    }
}
