//
//  APIGateway.swift
//  SampleRepoList
//
//  Created by yusaku maki on 2021/06/10.
//

import Foundation
import UIKit

private struct Url {
    static let searchRepositories: URL = URL(string: "https://api.github.com/search/repositories")!
}

protocol APIGatewayProtocol {
    func fetchRepositories(_ query: String, _ completion: @escaping (Result<GithubRepoList, NSError>) -> Void)
    func fetchImage(url: URL, _ completion: @escaping (Result<UIImage, NSError>) -> Void)
}

final class APIGateway: APIGatewayProtocol {
    func fetchRepositories(_ query: String, _ completion: @escaping (Result<GithubRepoList, NSError>) -> Void) {
        var components = URLComponents(url: Url.searchRepositories, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "q", value: query)]
        guard let url = components?.url else { return }
        let client = APIClient()
        client.get(url) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(GithubRepoList.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(NSError(domain: "", code: NSURLErrorCannotParseResponse, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchImage(url: URL, _ completion: @escaping (Result<UIImage, NSError>) -> Void) {
        let client = APIClient()
        client.get(url) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
