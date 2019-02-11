//
//  Book.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

import ObjectMapper

struct Book: ImmutableMappable {
    let id: Int //swiftlint:disable:this identifier_name
    let title: String
    let author: String
    let pages: [Page]
    let coverImageUrl: String

    init(map: Map) throws {
        id = try map.value("id")
        title = try map.value("title")
        author = try map.value("author")
        pages = (try? map.value("pages")) ?? []
        coverImageUrl = try map.value("coverImageUrl")
    }

}
