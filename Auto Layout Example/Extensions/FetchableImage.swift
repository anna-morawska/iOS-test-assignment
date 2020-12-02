import Foundation

protocol FetchableImage {
    func localFileUrl(for imageUrl: String?, options: FetchableImageOptions?) -> URL?

    func fetchImage(from urlString: String?, options: FetchableImageOptions?, completion: @escaping (_ imageData: Data?) -> Void)
}

extension FetchableImage {
    func localFileUrl(for imageURL: String?, options: FetchableImageOptions? = nil) -> URL? {
        let opt = FetchableImageHelper.getOptions(options)
        let targetDir = opt.storeInCacheDirectory ?
            FetchableImageHelper.cacheDirectoryUrl :
            FetchableImageHelper.documentsDirectoryUrl

        guard let urlString = imageURL else {
                guard let customFileName = opt.customFileName else { return nil }
                return targetDir.appendingPathComponent(customFileName)
        }

        guard let imageName = FetchableImageHelper.getImageName(from: urlString) else { return nil }
        return targetDir.appendingPathComponent(imageName)
    }

    func fetchImage(from urlString: String?, options: FetchableImageOptions? = nil, completion: @escaping (_ imageData: Data?) -> Void) {
        let opt = FetchableImageHelper.getOptions(options)
        let localUrl = self.localFileUrl(for: urlString, options: options)

        if opt.allowLocalStorage, let localUrl = localUrl, FileManager.default.fileExists(atPath: localUrl.path) {
            let loadedImageData = FetchableImageHelper.loadLocalImage(from: localUrl)
            completion(loadedImageData)
        } else {
            guard let urlString = urlString, let url = URL(string: urlString) else {
                completion(nil)
                return
            }

            FetchableImageHelper.downloadImage(from: url) { (imageData) in
                if opt.allowLocalStorage, let localUrl = localUrl {
                    try? imageData?.write(to: localUrl)
                }

                completion(imageData)
            }
        }
    }

}

struct FetchableImageOptions {
    var allowLocalStorage: Bool = true
    var storeInCacheDirectory: Bool = true
    var customFileName: String?
}

private struct FetchableImageHelper {
    static var cacheDirectoryUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    static var documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    static func getOptions(_ options: FetchableImageOptions?) -> FetchableImageOptions {
        return options != nil ? options! : FetchableImageOptions()
    }

    static func getImageName(from urlString: String) -> String? {
        guard var base64String = urlString.data(using: .utf8)?.base64EncodedString() else { return nil }
        // remove all non-alphanumeric - it returns array of non-alphanumeric characters. rejoin the separated pieces back to one string again.
        base64String = base64String.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()

        guard base64String.count < 50 else {
            return String(base64String.dropFirst(base64String.count - 50))
        }

        return base64String
    }

    static func loadLocalImage(from url: URL) -> Data? {
        do {
            let imageData = try Data(contentsOf: url)
            return imageData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    static func downloadImage(from url: URL, completion: @escaping (_ imageData: Data?) -> Void) {
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }

            completion(data)
        }
        task.resume()
    }

}
