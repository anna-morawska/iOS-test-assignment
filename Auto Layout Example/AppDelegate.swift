import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    internal var coordinator: Coordinator?
    internal var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navController = NavigationController()
        self.coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        window.rootViewController = navController
        window.makeKeyAndVisible()

        return true
    }
}
