import UIKit

class ContactListViewModel {
    internal let buttonLabel = "FETCH"
    internal let buttonId = "fetchButton"

    private let networking = Networking()
    
    internal var showContactDetails: (() -> Void)?

    static let contactDetails = ContactDetails(email: "anna.morawska@mooncascade.com", phone: "123 123 123")

    internal var employees: [Employee] = [Employee(fname: "Mark", lname: "Zuckerberg", contact_details: contactDetails, position: "IOS", projects: ["Indigo", "Fitek", "Flaim", "MCWeb", "The Global Hack"], image: "Avatar"),  Employee(fname: "Anna", lname: "Morawska", contact_details: contactDetails, position: "WEB", projects: ["Indigo", "Fitek", "Flaim", "MCWeb", "The Global Hack"],  image: "Avatar_2")]

    internal var tartuEmployees: [Employee] = []

    internal func getTallinnEmployees() {
        networking.performNetworkTask(endpoint: TallinnJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            self?.employees = response.employees
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
