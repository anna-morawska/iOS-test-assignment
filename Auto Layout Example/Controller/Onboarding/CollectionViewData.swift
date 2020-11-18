import UIKit

class CollectionViewData: NSObject {
    var pageDidChange: ((Int) -> Void)?
    var pages: [Page] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    public var currentPage: Int {
            guard let view = collectionView, let frame = collectionView?.visibleCells.first?.frame  else {
                return 0
            }
           return Int(frame.minX / view.frame.size.width)
    }

    weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.delegate = self
            setup()
        }
    }

    public func moveSlide(forward: Bool) {
        var scrollToIndex: Int

        if forward {
            scrollToIndex = min(currentPage + 1, pages.count - 1)
        } else {
            scrollToIndex =  max(currentPage - 1, 0)
        }

        let indexPath = IndexPath(item: scrollToIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath , at: .centeredHorizontally, animated: true)

        pageDidChange?(scrollToIndex)
    }

    private func setup() {
        collectionView?.register(PageCellView.self, forCellWithReuseIdentifier: PageCellView.Identifier)
    }

}

extension CollectionViewData: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageDidChange?(currentPage)
    }
}

extension CollectionViewData: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCellView.Identifier, for: indexPath) as! PageCellView // swiftlint:disable:this force_cast
        let page = pages[indexPath.item]

        cell.imageView.image = page.image
        cell.titleLabel.text = page.headerText
        cell.descriptionLabel.text = page.description

        return cell
    }
}

extension CollectionViewData: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
    }
}
