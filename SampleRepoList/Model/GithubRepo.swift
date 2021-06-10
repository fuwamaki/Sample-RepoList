//
//  GithubRepo.swift
//  SampleRepoList
//
//  Created by yusaku maki on 2021/06/10.
//

import Foundation

struct GithubRepo: Codable {
    let fullName: String
    let stargazersCount: Int
    let htmlUrl: String
    let owner: GithubRepoOwner

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
        case owner
    }

    init(fullName: String, stargazersCount: Int, htmlUrl: String, owner: GithubRepoOwner) {
        self.fullName = fullName
        self.stargazersCount = stargazersCount
        self.htmlUrl = htmlUrl
        self.owner = owner
    }
}
