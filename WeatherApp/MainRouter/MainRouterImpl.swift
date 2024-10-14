import UIKit

final class MainRouterImpl: MainRouter {
    static func createMainScreenModule() -> UIViewController {
        let interactor = MainScreenInteractorImpl()
        let router = MainScreenRouterImpl()
        let presenter = MainScreenPresenterImpl(interactor: interactor,
                                                router: router)
        let mainScreenViewController = MainScreenViewController(presenter: presenter)
 
        presenter.setView(view: mainScreenViewController)
        interactor.presenter = presenter
        
        return mainScreenViewController
    }
}
