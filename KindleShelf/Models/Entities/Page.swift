//
//  Page.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import ObjectMapper

struct Page: ImmutableMappable {
    let id: Int //swiftlint:disable:this identifier_name
    let text: String

    init(map: Map) throws {
        id = try map.value("id")
        text = try map.value("text")
    }

}
