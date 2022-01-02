//
//  Post.swift
//  SeSAC_SimpleSNS
//
//  Created by 최혜린 on 2022/01/02.
//

import Foundation

// MARK: - PostElement
struct PostElement: Codable {
    let id: Int
    let text: String
    let user: Writer
    let createdAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case comments
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let comment: String
    let user, post: Int
}

// MARK: - Writer
struct Writer: Codable {
    let id: Int
    let username, email: String
}

typealias Post = [PostElement]
