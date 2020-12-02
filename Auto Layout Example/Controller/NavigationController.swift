import UIKit

public protocol NavigationBarAppearance {
    var isNavigationBarHidden: Bool { get }
    var canNavigateBack: Bool { get }
    var screenTitle: String? { get }
}

class NavigationController: UINavigationController, UISearchControllerDelegate {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        delegate = self
        setup()
    }

    private func setup() {
        let navBarAppearance =  UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .tealBlue

        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.prefersLargeTitles = true
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white

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
                navigationController.navigationItem.backBarButtonItem?.isEnabled = false
                navigationController.interactivePopGestureRecognizer?.isEnabled = false
            }

            if let title = barAppearanceViewController.screenTitle {
                viewController.title = title
                viewController.navigationItem.largeTitleDisplayMode = .always
            } else {
                viewController.navigationItem.largeTitleDisplayMode = .never
            }

            if viewController is UISearchResultsUpdating {
                let searchBar = viewController.navigationItem.searchController?.searchBar

                if let textfield = searchBar?.value(forKey: "searchField") as? UITextField {
                    textfield.textColor = .black
                    textfield.backgroundColor = .white
                }
            }
        }
    }
}
