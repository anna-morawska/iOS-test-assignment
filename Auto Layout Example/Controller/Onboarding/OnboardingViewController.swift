import UIKit

class OnboardingViewController: UIViewController {
    private let viewModel: OnboardingViewModel
    private let collectionViewData = CollectionViewData()

    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        let view = OnboardingView()
        self.view = view

        bind(to: view)
    }

    private func bind(to view: OnboardingView) {
        view.pageControl.numberOfPages = viewModel.pages.count

        view.nextButton.setTitle(
            viewModel.nextButtonLabel, for: .normal)
        view.nextButton.restorationIdentifier = viewModel.nextButtonId
        view.nextButton.addTarget(
            self,
            action: #selector(buttonTouched(sender:)),
            for: .touchUpInside
        )

        view.prevButton.setTitle(viewModel.prevButtonLabel, for: .normal)
        view.prevButton.restorationIdentifier = viewModel.prevButtonId
        view.prevButton.addTarget(
            self,
            action: #selector(buttonTouched(sender:)),
            for: .touchUpInside
        )

        collectionViewData.collectionView = view.collectionView
        collectionViewData.pages = viewModel.pages
        collectionViewData.pageDidChange = { [weak view] index in
            view?.pageControl.currentPage = index
        }
    }

    @objc
    private func buttonTouched(sender: UIButton) {
        guard let id = sender.restorationIdentifier else { return }

        if id == viewModel.nextButtonId {
            if collectionViewData.currentPage == collectionViewData.pages.count - 1 {
                finishOnboarding()
            } else {
                collectionViewData.moveSlide(forward: true)
            }
        } else if id == viewModel.prevButtonId {
            collectionViewData.moveSlide(forward: false)
        }
    }

    private func finishOnboarding() {
        if let finishOnboarding = viewModel.finishOnboarding {
            finishOnboarding()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController: NavigationBarAppearance {
    var screenTitle: String? {
        return nil
    }

    var canNavigateBack: Bool {
        return true
    }

    var isNavigationBarHidden: Bool {
        return true
    }
}
