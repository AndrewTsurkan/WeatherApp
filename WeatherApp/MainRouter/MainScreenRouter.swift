import UIKit

protocol MainRouter: AnyObject {
    static func createMainScreenModule() -> UIViewController
}
