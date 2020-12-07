import UIKit
import Contacts
import ContactsUI

class ContactListViewModel {
    private let networking = Networking()
    private let dispatchGroup = DispatchGroup()
    internal var employees = [EnrichedEmployeeData]()
    internal var filteredEmployees = [EnrichedEmployeeData]()
    internal var showContactDetails: ((EnrichedEmployeeData) -> Void)?
    internal var currentContactId = 0

    internal func getEmployees(completion: @escaping (() -> Void)) {
        getTallinnEmployees()
        getTartuEmployees()

        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }

    internal func findMatchingContactForEmployee(employee: EmployeeData) -> CNContact? {
        do {
            let store = CNContactStore()
            let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactViewController.descriptorForRequiredKeys()] as! [CNKeyDescriptor]
            let predicate = CNContact.predicateForContacts(matchingName: employee.fullName)
            let contact = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch).first

            return contact
        } catch {
            print("Failed to fetch contact, error: \(error.localizedDescription)")
            return nil
        }
    }

    internal func enrichEmployeeData(employee: EmployeeData, location: Location) -> EnrichedEmployeeData {
        let contact = findMatchingContactForEmployee(employee: employee)
        currentContactId += 1
        return EnrichedEmployeeData(employeeData: employee, location: location, contact: contact, contactId: currentContactId)
    }

    internal func getTallinnEmployees() {
        dispatchGroup.enter()
        networking.performNetworkTask(endpoint: TallinnJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            let employees =  response.employees.map { employee  in
                self!.enrichEmployeeData(employee: employee, location: .tallinn)
            }
            self?.employees.append(contentsOf: employees)
            self?.dispatchGroup.leave()
        }
    }

    internal func getTartuEmployees() {
        dispatchGroup.enter()
        networking.performNetworkTask(endpoint: TartuJobApi.employeesList, type: Employees.self) { [weak self] (response) in
            let employees =  response.employees.map { employee  in
                self!.enrichEmployeeData(employee: employee, location: .tartu)
            }
            self?.employees.append(contentsOf: employees)
            self?.dispatchGroup.leave()
        }
    }

    internal func filterEmployess(_ filter: String, location: Location? = .all) {
        filteredEmployees = employees.filter({ (employee) -> Bool in
                let doesLocationMatch = location == .all || employee.location == location

                if filter.isEmpty {
                    return doesLocationMatch
                } else {
                    return doesLocationMatch && employee.matches(query: filter)
                }
            }
        )
    }

    internal func groupEmployees(employess: [EnrichedEmployeeData]) -> [EmployeesSection] {
        let uniqueEmloyees = Array(Set(employess))

        let groups = Dictionary(grouping: uniqueEmloyees) { (enrichedEmployeeData) -> String in
            return enrichedEmployeeData.employeeData.position
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
