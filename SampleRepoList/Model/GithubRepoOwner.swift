//
//  GithubRepoOwner.swift
//  SampleRepoList
//
//  Created by yusaku maki on 2021/06/10.
//

import Foundation

struct GithubRepoOwner: Codable {
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }

    init(avatarUrl: String) {
        self.avatarUrl = avatarUrl
    }
}
