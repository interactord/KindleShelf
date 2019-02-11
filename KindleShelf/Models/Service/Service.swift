//
//  Service.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import Foundation

struct Service: HasApiProvider {
    let apiProvider: ApiProvider

    init(apiProvider: ApiProvider) {
        self.apiProvider = apiProvider
    }
}
