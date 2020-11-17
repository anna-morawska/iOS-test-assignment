import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    internal var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            let window = UIWindow()
            self.window = window

            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let swipingController = SwipingController(collectionViewLayout: layout)

            window.rootViewController = swipingController
            window.makeKeyAndVisible()

        return true
    }
}
