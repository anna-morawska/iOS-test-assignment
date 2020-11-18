import Foundation

struct Employee: Codable {
    let fname: String
    let lname: String
    let contact_details: ContactDetails  // swiftlint:disable:this identifier_name
    let position: String
    let projects: [String]?
}

enum Position {
    case IOS, ANDROID, WEB, PM, TESTER, SALES, OTHER  // swiftlint:disable:this identifier_name
}
