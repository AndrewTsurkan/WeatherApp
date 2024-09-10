import Foundation

struct NetworkDataFetcher {
    private let networkSecvice = NetworkManager()
    
    func fetchJson<T: Codable>(urlString: String,  closure: @escaping (Result<T, Error>) -> ()) {
        networkSecvice.request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    closure(.success(response))
                } catch let error {
                    closure(.failure(error))
                }
            case .failure(let error):
                closure(.failure(error))
            }
        }
    }
}
