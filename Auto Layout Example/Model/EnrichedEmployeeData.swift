import Foundation
import Contacts

struct EnrichedEmployeeData {
    let employeeData: EmployeeData
    let location: Location
    let contact: CNContact?
    let contactId: Int
    var fullName: String {
        return "\(employeeData.lname) \(employeeData.fname)"
    }

}

extension EnrichedEmployeeData: Comparable, Hashable {
    static func < (lhs: EnrichedEmployeeData, rhs: EnrichedEmployeeData) -> Bool {
        return lhs.fullName.lowercased() < rhs.fullName.lowercased()
    }

    static func == (lhs: EnrichedEmployeeData, rhs: EnrichedEmployeeData) -> Bool {
        return lhs.fullName.lowercased() == rhs.fullName.lowercased()
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(fullName.lowercased())
    }
}

extension EnrichedEmployeeData: Searchable {
    func matches(query: String) -> Bool {
        let constituents: [Searchable] = [fullName, employeeData.position, employeeData.contact_details.email, employeeData.projects ?? []]
        return constituents.contains(where: { $0.matches(query: query) })
    }
}
