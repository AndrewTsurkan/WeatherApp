import UIKit

protocol MainScreenPresenter: AnyObject {
    func onViewDidLoad()
    func didSelectRow(at indexPath: IndexPath, viewController: UIViewController)
    func numberOfRows() -> Int
    func configureCell(_ cell: MainScreenCustomCell, forRowAt indexPath: IndexPath)
    func getData(data: Response)
    func getCity(city: String)
    func deleteItem(at: IndexPath)
}
