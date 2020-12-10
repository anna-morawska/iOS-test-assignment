import Foundation

struct EmployeeData: Codable {
    let fname: String
    let lname: String
    let contact_details: ContactDetails  // swiftlint:disable:this identifier_name
    let position: String
    let projects: [String]?
}
