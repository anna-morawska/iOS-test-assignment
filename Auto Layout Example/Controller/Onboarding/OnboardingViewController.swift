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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

//    TODO: viewWillTransition

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
                navigateToContactList()
            } else {
                collectionViewData.moveSlide(forward: true)
            }
        } else if id == viewModel.prevButtonId {
            collectionViewData.moveSlide(forward: false)
        }
    }

    private func navigateToContactList() {
        let contactList = ContactListController()
        self.navigationController?.pushViewController(contactList, animated: true)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
