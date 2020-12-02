import Foundation

struct EmployeeWithLocation {
    enum Location {
        case tartu
        case tallinn
    }
    let employee: Employee
    let location: Location
}

struct Employee: Codable {
    let fname: String
    let lname: String
    let contact_details: ContactDetails  // swiftlint:disable:this identifier_name
    let position: String
    let projects: [String]?
    let image: String?
    var fullName: String {
        return "\(lname) \(fname)"
    }
}

extension Employee: Comparable, Hashable {
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.fullName.lowercased() < rhs.fullName.lowercased()
    }

    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.fullName.lowercased() == rhs.fullName.lowercased()
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(fullName.lowercased())
    }
}

extension Employee: Searchable {
    func matches(query: String) -> Bool {
        let constituents: [Searchable] = [fullName, position, contact_details.email, projects ?? []]
        return constituents.contains(where: { $0.matches(query: query) })
    }
}
