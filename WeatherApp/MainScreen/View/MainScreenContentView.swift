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
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        backgroundColor = #colorLiteral(red: 0.1434547901, green: 0.4479960799, blue: 0.7350915074, alpha: 1)
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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
}
