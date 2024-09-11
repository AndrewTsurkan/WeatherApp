import UIKit

final class MainScreenPresenterImpl: NSObject {
    weak var view: MainScreenView?
    var interactor: MainScreenInteractor?
    var router: MainRouter?
    var data: [Response] = [] {
        didSet {
            view?.reload()
        }
    }
}

//MARK: - MainScreenPresenter -
extension MainScreenPresenterImpl: MainScreenPresenter {
    func onViewDidLoad() {
        
    }
    
    func didSelectRow(at indexPath: IndexPath) {
      //TODO: - routing
    }
    
    func numberOfRows() -> Int {
        data.count
    }
    
    func configureCell(_ cell: MainScreenCustomCell, forRowAt indexPath: IndexPath) {
        let cellData = data[indexPath.row]
        guard let imageString =  cellData.current.condition.icon,
              let temp = cellData.current.temp else { return }
        Task {
            guard let image = await self.interactor?.getImage(imageString: imageString) else { return }
            DispatchQueue.main.async {
                cell.forecastImage.image = image
            }
        }
        
        let tempString = String(temp)
        cell.currentTemperature.text = "\(tempString)°"
        cell.locationLabel.text = cellData.location.name
        
    }
    
    func getData(data: Response) {
        self.data.append(data)
    }
}
