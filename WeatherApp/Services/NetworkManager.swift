import Foundation

struct NetworkManager {
    
    enum APIError: Error {
        case unknown
        case invalidURL
        case invalidData
    }
    
    func request(urlString: String, completion: @escaping ( Result<Data,Error>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(APIError.unknown))
                return
            }
            guard let data else {
                completion(.failure(APIError.invalidData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
