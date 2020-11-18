import Foundation

struct Networking {

    func performNetworkTask<T: Codable>(endpoint: EndpointType,
                                        type: T.Type,
                                        completion: ((_ response: T) -> Void)?) {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        let urlRequest = URLRequest(url: url)

        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let _ = error {
                return
            }
            guard let data = data else {
                return
            }
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return
            }
            completion?(decoded)
        }

        urlSession.resume()
    }

}
