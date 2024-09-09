import UIKit

final class MainRouterImpl: MainRouter {
    static func createMainScreenModule() -> UIViewController {
        let mainScreenViewController = MainScreenViewController()
        return mainScreenViewController
    }
}
