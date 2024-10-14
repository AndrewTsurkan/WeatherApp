import UIKit

final class DetailScreenContentView: UIView {
    //MARK: - Private properties -
    private let currentLocationLabel = UILabel()
    private let currentTempLabel = UILabel()
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = #colorLiteral(red: 0.1434547901, green: 0.4479960799, blue: 0.7350915074, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

//MARK: - Public -
extension DetailScreenContentView {
    func setDelegate(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func configure(data: ContentViewData) {
        currentLocationLabel.text = data.locationName
        currentTempLabel.text = "\(data.currentTemp)°"
    }
    
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.layoutIfNeeded()
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - UI -
private extension DetailScreenContentView {
    func setupUI() {
        setupCollectionView()
        addSubviews()
        makeConstraints()
        setupCurrentLocationLabel()
        setupCurrentTempLabel()
    }
    
    func addSubviews() {
        addSubview(currentLocationLabel)
        addSubview(currentTempLabel)
        addSubview(collectionView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
        
        currentLocationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
        currentLocationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        currentTempLabel.topAnchor.constraint(equalTo: currentLocationLabel.bottomAnchor, constant: 10),
        currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        collectionView.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 20),
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        collectionView.heightAnchor.constraint(equalToConstant: 300)])
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self?.createHourlySection()
            case 1:
                return self?.createDaySection()
            default:
                return nil
            }
        }
    }
    
    func createHourlySection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 10, leading: 5, bottom: 10, trailing: 5)
        return section

    }
    
    func createDaySection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.boundarySupplementaryItems = [createHeader()]
        section.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 10)
        return section
    }
    
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        return header
    }
    
    func setupCurrentLocationLabel() {
        currentLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        currentLocationLabel.textColor = .black
        currentLocationLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        currentLocationLabel.textAlignment = .center
    }
    
    func setupCurrentTempLabel() {
        currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTempLabel.textColor = .black
        currentTempLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        currentTempLabel.textAlignment = .center
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HourlyCollectionCell.self,
                                forCellWithReuseIdentifier: HourlyCollectionCell.identifier)
        collectionView.register(DayCollectionCell.self,
                                forCellWithReuseIdentifier: DayCollectionCell.identifier)
        collectionView.register(HeaderSupplementaryView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderSupplementaryView.identifier)
        collectionView.backgroundColor = #colorLiteral(red: 0.4875565171, green: 0.658501327, blue: 0.8347119689, alpha: 1)
        collectionView.layer.cornerRadius = 16
        collectionView.isScrollEnabled = false
    }
}
