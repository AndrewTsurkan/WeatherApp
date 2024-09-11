import UIKit

struct ImageDownloader {
    func requestImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
            } else if let data {
                guard let image = UIImage(data: data) else {
                    let error = NSError(domain: "", code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: "Could not generate image from data"])
                    completion(.failure(error))
                    return
                }
                completion(.success(image))
            }
        }.resume()
    }
}
