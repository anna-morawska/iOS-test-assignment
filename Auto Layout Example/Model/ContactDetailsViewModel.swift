import UIKit

class ContactDetailsViewModel {
    private let networking = Networking()
    public let employee: Employee

    init(employee: Employee) {
        self.employee = employee
    }
}
