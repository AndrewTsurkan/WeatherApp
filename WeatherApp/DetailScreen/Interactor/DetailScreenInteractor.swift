import UIKit

protocol DetailScreenInteractor: AnyObject {
    func getData(city: String)
    func getImage(imageString: String) async -> UIImage?
}
