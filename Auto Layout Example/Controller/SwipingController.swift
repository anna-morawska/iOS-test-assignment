import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let swipingViewModel: SwipingViewModel

    init(swipingViewModel: SwipingViewModel) {
        self.swipingViewModel = swipingViewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        let view = SwipingView()
        self.collectionView = view

        bind(view, to: swipingViewModel)
    }

    private func bind(_ view: SwipingView, to viewModel: SwipingViewModel) {
        view.nextButton.setTitle(viewModel.nextButtonTitle, for: .normal)
        view.nextButton.addTarget(
            self,
            action: #selector(moveSlide(sender:)),
            for: .touchUpInside
        )

        view.prevButton.setTitle(viewModel.prevButtonTitle, for: .normal)
        view.prevButton.addTarget(
            self,
            action: #selector(moveSlide(sender:)),
            for: .touchUpInside
        )

        view.pageControl.currentPage = viewModel.currentPage
        view.pageControl.numberOfPages = viewModel.pages.count
    }

    @objc
    private func moveSlide(sender: UIButton) {
        guard let id = sender.restorationIdentifier else { return }

        if id == K.nextButtonId {
            swipingViewModel.incrementCurrentPage()

        } else if id == K.prevButtonId {
            swipingViewModel.decrementCurrentPage()
        }

        let indexPath = IndexPath(item: swipingViewModel.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

//      pageControl.currentPage = nextIndex

    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { (_) in
            self.collectionViewLayout.invalidateLayout()

            let indexPath = IndexPath(item: self.swipingViewModel.currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        } completion: { (_) in  }

    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                            withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
//        pageControl.currentPage = index
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Collection View Methods
extension SwipingController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellId, for: indexPath) as! PageCellView // swiftlint:disable:this force_cast

        cell.page = swipingViewModel.pages[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swipingViewModel.pages.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
