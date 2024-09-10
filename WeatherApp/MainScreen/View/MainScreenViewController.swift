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
        contentView.setupDelegate(delegate: self, dataSource: self)
    }
}

//MARK: - MAinScreenView -
extension MainScreenViewController: MainScreenView {
 
}

//MARK: - UITableViewDelagete, UITableViewDataSource -
 extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenCustomCell.identifier, for: indexPath) as? MainScreenCustomCell else { return UITableViewCell() }
        presenter?.configureCell(cell, forRowAt: indexPath)
        return cell
    }
}

