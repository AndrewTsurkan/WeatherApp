import UIKit

final class MainScreenRouterImpl: MainScreenRouter {
    func pushDetailViewController(city: String, viewController: UIViewController) {
        let interactor = DetailScreenInteractorImpl()
        let presenter = DetailScreenPresenterImpl(interactor: interactor,
                                                  city: city)
        let detailScreenViewController = DetailScreenViewController(presenter: presenter)
        interactor.presenter = presenter
        presenter.setView(view: detailScreenViewController)
        viewController.navigationController?.pushViewController(detailScreenViewController, animated: true)
        
    }
}
