import UIKit

final class DetailScreenViewController: UIViewController {
    //MARK: - Private properties -
    private let presenter: DetailScreenPresenter
    private let contentView = DetailScreenContentView()
    
    //MARK: - Life cycle -
    override func loadView() {
        view = contentView
    }
    
    init(presenter: DetailScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        presenter.onViewDidLoad()
    }
}

//MARK: - DateilScreenViewController -
extension DetailScreenViewController: DetailScreenView {
    func configure(data: ContentViewData) {
        contentView.configure(data: data)
    }
    
    func reloadCollectioView() {
        contentView.reload()
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate -
extension DetailScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter.numberOfItemsInHourlySection()
        case 1:
            return presenter.numberOfItemsInDaySection()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionCell.identifier, for: indexPath) as? HourlyCollectionCell else { return UICollectionViewCell() }
            presenter.configureHourlyCell(cell: cell, forRowAt: indexPath)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionCell.identifier, for: indexPath) as? DayCollectionCell else { return UICollectionViewCell() }
            presenter.configureDayCell(cell: cell, forRowAt: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: HeaderSupplementaryView.identifier,
                                                                             for: indexPath) as! HeaderSupplementaryView
            return headerView
        }
        return UICollectionReusableView()
    }
}

//MARK: - Private -
extension DetailScreenViewController {
    func setupDelegate() {
        contentView.setDelegate(delegate: self, dataSource: self)
        contentView.reload()
    }
}
