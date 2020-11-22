import Foundation

class K { // swiftlint:disable:this type_name

    static let prevButtonId = "prevButton"
    static let nextButtonId = "nextButton"
    static let cellId = "cellId"

    // TODO: remove
    static let contactDetails = ContactDetails(email: "anna.morawska@mooncascade.com", phone: "123 123 123")
    static let mockedEmployee = Employee(fname: "Anna", lname: "Morawska", contact_details: K.contactDetails, position: "WEB", projects: ["Indigo", "Fitek", "Flaim", "MCWeb", "The Global Hack"],  image: "Avatar_2")

    static let mockedEmployee2 = Employee(fname: "Mark", lname: "Zuckerberg", contact_details: K.contactDetails, position: "IOS", projects: ["Indigo", "Fitek", "Flaim", "MCWeb", "The Global Hack"], image: "Avatar")
}
