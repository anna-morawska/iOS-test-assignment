import UIKit

class CollectionViewData: NSObject {
    var pageDidChange: ((Int) -> Void)?
    var pages: [Page] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.delegate = self
            setup()
        }
    }

    public func moveSlide(forward: Bool) {
        guard let view = collectionView, let frame = collectionView?.visibleCells.first?.frame  else {
            return
        }

        var currentPage = Int(frame.minX / view.frame.size.width)

        if forward {
            currentPage = min(currentPage + 1, pages.count - 1)
        } else {
            currentPage =  max(currentPage - 1, 0)
        }

        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView?.scrollToItem(at: indexPath , at: .centeredHorizontally, animated: true)

        pageDidChange?(currentPage)
    }

    private func setup() {
        collectionView?.register(PageCellView.self, forCellWithReuseIdentifier: PageCellView.Identifier)
    }

}

extension CollectionViewData: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)

        pageDidChange?(page)
    }
}

extension CollectionViewData: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCellView.Identifier, for: indexPath) as! PageCellView
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
