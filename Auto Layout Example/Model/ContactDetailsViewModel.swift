import UIKit
import Contacts

class ContactDetailsViewModel: FetchableImage {
    public let employee: EnrichedEmployeeData
    internal var showContactApp: ((CNContact) -> Void)?

    init(employee: EnrichedEmployeeData) {
        self.employee = employee
    }

    func fetchAvatarImage(avatarNumber: Int, completion: @escaping (_ image: UIImage?) -> Void) {
        let avatarUrl = "https://rickandmortyapi.com/api/character/avatar/\(avatarNumber).jpeg"

        fetchImage(from: avatarUrl, options: nil) { (data) in
            let image: UIImage?
            if let avatarData = data {
                image = UIImage(data: avatarData)
            } else {
                image = UIImage(named: "Avatar")
            }

            completion(image)
        }
    }
}
