import UIKit

final class DetailScreenPresenterImpl {
    weak var view: DetailScreenView?
    var city: String
    private var detailData: DetailScreenResponse? {
        didSet {
            view?.reloadCollectioView()
            congigureCurrentLocation()
        }
    }
    private let interactor: DetailScreenInteractor
    
    init(interactor: DetailScreenInteractor, city: String) {
        self.interactor = interactor
        self.city = city
    }
}

//MARK: - Public -
extension DetailScreenPresenterImpl {
    func setView(view: DetailScreenView) {
        self.view = view
    }
}

//MARK: - DetailScreenPresenter -
extension DetailScreenPresenterImpl: DetailScreenPresenter {
    func numberOfItemsInDaySection() -> Int {
        guard let itemsCount = detailData?.forecast.forecastDay.count else { return 0 }
        return itemsCount
    }
    
    func numberOfItemsInHourlySection() -> Int {
        guard let hourDataArray = detailData?.forecast.forecastDay.first?.hour else { return 0 }
        let calendar = Calendar.current
        let currentEpochTime = getEpochTime()
        let futureHours = hourDataArray.filter { hourData in
            guard let epochTime = hourData.time else { return false }
            let forecastDate = Date(timeIntervalSince1970: TimeInterval(epochTime))
            let forecastHour = calendar.component(.hour, from: forecastDate)
            let currentDate = Date(timeIntervalSince1970: currentEpochTime)
            let currentHour = calendar.component(.hour, from: currentDate)
            return forecastHour >= currentHour
        }
        return futureHours.count
    }
    
    func onViewDidLoad() {
        interactor.getData(city: city)
    }
    
    func configureDayCell(cell: DayCollectionCell, forRowAt indexPath: IndexPath) {
        guard let detailData else { return }
        let dayDataArray = detailData.forecast.forecastDay[indexPath.item]
        guard let epochDay = dayDataArray.date else { return }
        let dayOfWeekString = getDayOfWeek(epochDay)
        guard let imageString = dayDataArray.day.condition.icon else { return }
        Task {
            guard let icon = await interactor.getImage(imageString: imageString),
            let tempDouble = dayDataArray.day.temp else { return }
            let dayData: CellData = .init(time: String(dayOfWeekString),
                                          temp: String(Int(tempDouble)),
                                          image: icon)
            await cell.configure(data: dayData)
        }
    }
    
    func configureHourlyCell(cell: HourlyCollectionCell, forRowAt indexPath: IndexPath) {
        guard let detailData else { return }
        let hourDataArray = detailData.forecast.forecastDay[0].hour[indexPath.item]
        guard let epochTime = hourDataArray.time else { return }
        let calendar = Calendar.current
        let currentDate = getEpochTime()
        let date = Date(timeIntervalSince1970: TimeInterval(epochTime))
        if epochTime >= Int(currentDate) {
            let hour = calendar.component(.hour, from: date)
            
            guard let imageString = hourDataArray.condition.icon else { return }
            Task {
                guard let icon = await interactor.getImage(imageString: imageString),
                      let tempDouble = hourDataArray.temp else { return }
                let hourData: CellData = .init(time: String(hour),
                                               temp: String(Int(tempDouble)),
                                               image: icon)
                await cell.configure(data: hourData)
            }
        }
    }
    
    func congigureCurrentLocation() {
       guard let locationName = detailData?.location.name,
             let currentTemp = detailData?.current.temp else { return }
        
        let currentData: ContentViewData = .init(locationName: locationName,
                                                 currentTemp: String(currentTemp))
        DispatchQueue.main.async { [weak self] in
            self?.view?.configure(data: currentData)
        }
    }
    
    func getData(data: DetailScreenResponse) {
        detailData = data
        let currentEpochTime = getEpochTime()
        detailData?.forecast.forecastDay[0].hour.removeAll { hourData in
            if let time = hourData.time {
                return Int(currentEpochTime) > time
            }
            return false
        }
    }
}

//MARK: - Private methods -
private extension DetailScreenPresenterImpl {
    func getEpochTime() -> TimeInterval {
        let currentDate = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour], from: currentDate)
        components.minute = 0
        components.second = 0
        guard let starOfHous = calendar.date(from: components) else { return 0 }
        let epochTime = starOfHous.timeIntervalSince1970
        return epochTime
    }
    
    func getDayOfWeek(_ epochTime: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(epochTime))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.locale = Locale(identifier: "ru_RU")
        var dayOfWeekString = formatter.string(from: date)
        dayOfWeekString = dayOfWeekString.capitalized
        return dayOfWeekString
    }
}

