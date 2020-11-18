import Foundation

enum TallinnJobApi {
    case employeesList
}

extension TallinnJobApi: EndpointType {
    var baseURL: URL {
        return URL(string: "https://tallinn-jobapp.aw.ee")!
    }

    var path: String {
        switch self {
        case .employeesList:
            return "/employee_list"
        }
    }
}
