import UIKit

class SwipingView: UICollectionView {
    public let prevButton = UIButton(type: .system)
    public let nextButton = UIButton(type: .system)
    public let pageControl = UIPageControl()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let customLayout = UICollectionViewFlowLayout()
        customLayout.scrollDirection = .horizontal

        super.init(frame: frame, collectionViewLayout: customLayout)

        setup()
        setLayout()
    }

    private func setup() {
        register(PageCellView.self, forCellWithReuseIdentifier: K.cellId)
        isPagingEnabled = true
        backgroundColor = .white
        showsHorizontalScrollIndicator = false

        prevButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        prevButton.setTitleColor(.darkGray, for: .normal)
        prevButton.restorationIdentifier = K.prevButtonId

        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nextButton.setTitleColor(.mainPink, for: .normal)
        nextButton.restorationIdentifier = K.nextButtonId

        pageControl.currentPageIndicatorTintColor = .mainPink
        pageControl.pageIndicatorTintColor = .fadedPink
    }

    private func setLayout() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        addSubview(bottomControlsStackView)
        bottomControlsStackView.distribution = .fillEqually
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false

//        bottomControlsStackView.pinEdgesToSuperview(edges: [.bottom, .left, .right])
//        bottomControlsStackView.set(dimension: .height, to: 50)
        
//        TODO:

        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
