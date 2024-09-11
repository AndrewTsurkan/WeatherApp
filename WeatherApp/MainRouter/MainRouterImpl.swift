import UIKit

final class MainRouterImpl: MainRouter {
    static func createMainScreenModule() -> UIViewController {
        let presenter = MainScreenPresenterImpl()
        let interactor = MainScreenInteractorImpl()
        let mainScreenViewController = MainScreenViewController()
        
        mainScreenViewController.presenter = presenter
        presenter.view = mainScreenViewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return mainScreenViewController
    }
}
