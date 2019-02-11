//
//  ApiProvider.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import RxSwift

protocol HasApiProvider {
    var apiProvider: ApiProvider { get }
}

protocol ApiProvider {
    func getBookList() -> Observable<[Book]>
    func getDetailAppgetBookCoverImage(url: String) -> Observable<UIImage>
}
