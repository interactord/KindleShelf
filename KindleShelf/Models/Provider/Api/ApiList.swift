//
//  ApiList.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

enum ApiList {
    case getBookList
    case getBookCoverImage(url: String)

    var url: String {
        switch self {
        case .getBookList:
            return "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json"
        case .getBookCoverImage(let url):
            return url
        }
    }
}
