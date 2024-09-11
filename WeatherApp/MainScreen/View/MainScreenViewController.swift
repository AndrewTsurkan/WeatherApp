import UIKit

class MainScreenViewController: UIViewController {
    //MARK: - Private properties -
    private let contentView = MainScreenContentView()
    var presenter: MainScreenPresenter?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onViewDidLoad()
        contentView.setupDelegate(delegate: self, dataSource: self)
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
        return cell
    }
}
