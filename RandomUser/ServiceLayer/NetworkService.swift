//
//  NetworkService.swift
//  RandomUser
//
//  Created by Yerzhan Gapurinov on 09.03.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData(completion: @escaping (Result<Response?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getData(completion: @escaping (Result<Response?, Error>) -> Void) {
        let url = URL(string: Constants.urlToServer)
        guard url != nil else {
            print("URL is nil")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                print("some error")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(result))
            } catch {
                print("failed to convert \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
