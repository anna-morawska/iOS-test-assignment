import UIKit

public protocol NavigationBarAppearance {
    var isNavigationBarHidden: Bool { get }
    var canNavigateBack: Bool { get }
    var screenTitle: String? { get }
}

class NavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setup()
    }

    private func setup() {
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let barAppearanceViewController = viewController as? NavigationBarAppearance {
            setNavigationBarHidden(barAppearanceViewController.isNavigationBarHidden, animated: true)

            if !barAppearanceViewController.canNavigateBack {
                viewController.navigationItem.leftBarButtonItem = nil
                viewController.navigationItem.hidesBackButton = true
                navigationItem.backBarButtonItem?.isEnabled = false
                interactivePopGestureRecognizer?.isEnabled = false
            }

            if let title = barAppearanceViewController.screenTitle {
                print(title)
                navigationBar.prefersLargeTitles = true
                viewController.title = title
            }
        }
    }
}
