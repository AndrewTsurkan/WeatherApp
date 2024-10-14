import UIKit
protocol DetailScreenPresenter: AnyObject {
    func configureHourlyCell(cell: HourlyCollectionCell, forRowAt indexPath: IndexPath)
    func configureDayCell(cell: DayCollectionCell, forRowAt indexPath: IndexPath)
    func getData(data: DetailScreenResponse)
    func onViewDidLoad()
    func numberOfItemsInDaySection() -> Int
    func numberOfItemsInHourlySection() -> Int
}
