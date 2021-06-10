//
//  APIClient.swift
//  SampleRepoList
//
//  Created by yusaku maki on 2021/06/10.
//

import Foundation

struct APIClient {
    func get(_ url: URL, completion: @escaping (Result<Data, NSError>) -> Void) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        let task: URLSessionDataTask = session.dataTask(with: url) { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error as NSError))
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
