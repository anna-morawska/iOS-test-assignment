import UIKit

class OnboardingView: UIView {
    public let pageControl = UIPageControl()
    public let collectionView: UICollectionView
    public let nextButton = UIButton(type: .system)
    public let prevButton = UIButton(type: .system)
    public let collectionViewLayout: UICollectionViewFlowLayout

    init() {
        self.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

        super.init(frame: .zero)
        setup()
        layout()
    }

    func setup() {
        backgroundColor = .white

        pageControl.currentPageIndicatorTintColor = .mainPink
        pageControl.pageIndicatorTintColor = .fadedPink

        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear

        prevButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        prevButton.setTitleColor(.darkGray, for: .normal)

        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nextButton.setTitleColor(.mainPink, for: .normal)
    }

    func layout() {

        let stackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        addSubview(stackView)

        stackView.distribution = .fillEqually
        stackView.pinEdgesToSuperview(edges: [.left, .right, .bottom])
        stackView.set(dimension: .height, to: 100)

        addSubview(collectionView)
        collectionView.pinEdgesToSuperview(edges: [.left, .top, .right])
        collectionView.pin(edge: .bottom, to: .top, of: stackView)

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
