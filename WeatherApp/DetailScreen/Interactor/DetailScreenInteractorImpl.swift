import UIKit

final class DetailScreenInteractorImpl {
    //MARK: - Private properties -
    private let networkDataFetcher = NetworkDataFetcher()
    private let imageManager = ImageDownloader()
    var presenter: DetailScreenPresenter?
}

//MARK: - DateilScreenInteractorImpl -
extension DetailScreenInteractorImpl: DetailScreenInteractor {
    func getData(city: String) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=27d247ae696845fd99092609231210&q=\(city)&days=10"
        networkDataFetcher.fetchJson(urlString: urlString) { [weak self] (result: Result<DetailScreenResponse, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in 
                    self?.presenter?.getData(data: data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImage(imageString: String) async -> UIImage? {
        let url = "https:" + imageString
        return await withCheckedContinuation { continuation in
            imageManager.requestImage(urlString: url) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        continuation.resume(returning: image)
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        continuation.resume(returning: nil)
                    }
                }
            }
        }
    }
}
