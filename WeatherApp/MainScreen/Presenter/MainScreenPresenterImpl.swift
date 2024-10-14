import UIKit

final class MainScreenPresenterImpl: NSObject {
    weak var view: MainScreenView?
    private var interactor: MainScreenInteractor?
    private var router: MainScreenRouter?
    private let userDefaultsKey = "WeatherData"
    private var defaultCity: [String] = ["Санкт-Петербург", "Москва"]
    private var data: [Response] = [] {
        didSet {
            saveDataToUserDefaults()
            view?.reload()
        }
    }
    
    init(interactor: MainScreenInteractor,
         router: MainScreenRouter) {
        self.interactor = interactor
        self.router = router
        super.init()
    }
    
    func setView(view: MainScreenViewController) {
        self.view = view 
    }
}

//MARK: - MainScreenPresenter -
extension MainScreenPresenterImpl: MainScreenPresenter {
    func onViewDidLoad() {
        loadDataFromUserDefaults()
    }
    
    func didSelectRow(at indexPath: IndexPath, viewController: UIViewController) {
        guard let city = data[indexPath.row].location.name else { return }
        router?.pushDetailViewController(city: city, viewController: viewController)
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
        let cityExists = data.contains { $0.location.name == city }
        if !cityExists {
            interactor?.getData(city: city)
        }
    }
    
    func deleteItem(at: IndexPath) {
        
        data.remove(at: at.row)
    }
}

//MARK: - UserDefaults -
private extension MainScreenPresenterImpl {
     func loadDataFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                let decoder = JSONDecoder()
                self.data = try decoder.decode([Response].self, from: savedData)
            } catch {
                print("decoding error")
            }
        } else {
            defaultCity.forEach { interactor?.getData(city: $0) }
        }
    }
    
    func saveDataToUserDefaults() {
        do {
            let encoder = JSONEncoder()
            let dataToSave = try encoder.encode(self.data)
            UserDefaults.standard.set(dataToSave, forKey: userDefaultsKey)
        } catch {
            print("Failed to encode data for UserDefaults: \(error)")
        }
    }
}
