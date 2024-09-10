import UIKit

protocol MainScreenPresenter: AnyObject {
    func onViewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
    func numberOfRows() -> Int
    func configureCell(_ cell: MainScreenCustomCell, forRowAt indexPath: IndexPath)
}
