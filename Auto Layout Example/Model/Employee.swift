import Foundation

struct Employee: Codable, Comparable, Hashable {
    let fname: String
    let lname: String
    let contact_details: ContactDetails  // swiftlint:disable:this identifier_name
    let position: String
    let projects: [String]?
    let image: String?

    static func < (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.lname.lowercased() < rhs.lname.lowercased()
    }

    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return "\(lhs.lname) \(lhs.fname)".lowercased() == "\(rhs.lname) \(rhs.fname)".lowercased()
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine("\(lname) \(fname)".lowercased())
    }
}
