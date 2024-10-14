import UIKit

final class MainScreenViewController: UIViewController {
    //MARK: - Private properties -
    private let contentView = MainScreenContentView()
    private var presenter: MainScreenPresenter?
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
        contentView.setupDelegate(delegate: self, dataSource: self)
        setupUISearch()
    }
    
    init(presenter: MainScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

//MARK: - MAinScreenView -
extension MainScreenViewController: MainScreenView {
    func reload() {
        contentView.reloadTableView()
    }
}

//MARK: - UITableViewDelagete, UITableViewDataSource -
extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenCustomCell.identifier, for: indexPath)
                as? MainScreenCustomCell else { return UITableViewCell() }
        self.presenter?.configureCell(cell, forRowAt: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath, viewController: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, view, completion) in
  
            if let presenter = self?.presenter {
                presenter.deleteItem(at: indexPath)
            }
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}

//MARK: - Private -
extension MainScreenViewController {
    func setupUISearch() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

//MARK: - UISearchResultsUpdating
extension MainScreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        performSearch(query: searchText)
        searchBar.resignFirstResponder()
    }
    
     func performSearch(query: String) {
        presenter?.getCity(city: query)
    }
}
