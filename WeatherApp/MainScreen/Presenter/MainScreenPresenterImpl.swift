import UIKit

final class MainScreenPresenterImpl: NSObject {
    weak var view: MainScreenView?
    private var interactor: MainScreenInteractor?
    private var router: MainRouter?
    private var city: [String] = ["Санкт-Петербург", "Москва"]
    var data: [Response] = [] {
        didSet {
            view?.reload()
        }
    }
    
    init(interactor: MainScreenInteractor,
         router: MainRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func setView(view: MainScreenViewController) {
        self.view = view 
    }
}

//MARK: - MainScreenPresenter -
extension MainScreenPresenterImpl: MainScreenPresenter {
    func onViewDidLoad() {
        city.forEach({interactor?.getData(city: $0 )})
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
    
    func getCity(city: String) {
        if !self.city.contains(city) {
            interactor?.getData(city: city)
        }
    }
}
