import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    internal var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.window = window

        let onboardingViewController = OnboardingViewController(
            viewModel: OnboardingViewModel()
        )

        window.rootViewController = onboardingViewController
        window.makeKeyAndVisible()

        return true
    }
}
