import Foundation
import Contacts

struct EnrichedEmployeeData {
    let employeeData: EmployeeData
    let location: Location
    let contact: CNContact?
    let contactId: Int
}

extension EnrichedEmployeeData: Comparable, Hashable {
    static func < (lhs: EnrichedEmployeeData, rhs: EnrichedEmployeeData) -> Bool {
        return lhs.employeeData.fullName.lowercased() < rhs.employeeData.fullName.lowercased()
    }

    static func == (lhs: EnrichedEmployeeData, rhs: EnrichedEmployeeData) -> Bool {
        return lhs.employeeData.fullName.lowercased() == rhs.employeeData.fullName.lowercased()
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(employeeData.fullName.lowercased())
    }
}

extension EnrichedEmployeeData: Searchable {
    func matches(query: String) -> Bool {
        let constituents: [Searchable] = [employeeData.fullName, employeeData.position, employeeData.contact_details.email, employeeData.projects ?? []]
        return constituents.contains(where: { $0.matches(query: query) })
    }
}
