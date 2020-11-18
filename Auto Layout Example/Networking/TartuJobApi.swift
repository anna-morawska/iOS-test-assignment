import Foundation

enum TartuJobApi {
    case employeesList
}

extension TartuJobApi: EndpointType {
    var baseURL: URL {
        return URL(string: "https://tartu-jobapp.aw.ee")!
    }

    var path: String {
        switch self {
        case .employeesList:
            return "/employee_list"
        }
    }
}
