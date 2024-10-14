import UIKit

protocol MainScreenRouter: AnyObject {
   func pushDetailViewController(city: String, viewController: UIViewController)
}
