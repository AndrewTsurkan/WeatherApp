import UIKit

final class MainScreenContentView: UIView {
    //MARK: - Private property -
    private let tableView = UITableView()
    
    //MARK: - Life cycle -
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    //TODO: - remove fatal error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Public -
extension MainScreenContentView {
    func displayData() {
        //TODO: - networkData
    }
    
    func setupDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    
}

//MARK: - UI -
private extension MainScreenContentView {
    func setupUI() {
        addSubviews()
        makeConstraints()
        setupTableView()
        backgroundColor = .systemBackground
    }
    
    func addSubviews() {
        addSubview(tableView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
])
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainScreenCustomCell.self, forCellReuseIdentifier: MainScreenCustomCell.identifier)
    }
}
