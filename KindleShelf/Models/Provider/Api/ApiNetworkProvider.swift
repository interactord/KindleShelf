//
//  ApiNetworkProvider.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import RxSwift

class ApiNetworkProvider: ApiProvider {

    private let network: Networking

    // MARK: Initializer

    init(network: Networking) {
        self.network = network
    }

    func getBookList() -> Observable<[Book]> {
        let url = ApiList.getBookList.url
        return network.requestList(method: .get, url: url, parameters: nil, type: Book.self)
    }

    func getDetailAppgetBookCoverImage(url: String) -> Observable<UIImage> {
        return Observable.never()
    }

//        let url = ApiList.getBookList.url
//        return network.request(method: .get, url: url, parameters: nil, type: Book.self)
//    }

//    func getDetailAppgetBookCoverImage(url: String) -> Observable<UIImage> {
//        let url = ApiList.getBookCoverImage(url: url).url
//        return network.image(url: url)
//    }

}
