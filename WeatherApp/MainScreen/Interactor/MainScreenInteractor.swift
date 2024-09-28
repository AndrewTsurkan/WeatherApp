import UIKit

protocol MainScreenInteractor: AnyObject {
    func getData(city: String)
    func getImage(imageString: String) async -> UIImage?
}
