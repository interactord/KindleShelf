//
//  BookViewModel.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 14/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import RxSwift
import RxCocoa

protocol BookViewModelInput {
}

protocol BookViewModelOutput {
    var title: BehaviorRelay<String> { get }
    var auth: BehaviorRelay<String> { get }
    var bookCover: Observable<UIImage> { get }
}

typealias BookViewModelType = BookViewModelInput & BookViewModelOutput

class BookViewModel: BookViewModelType {

    // MARK: ServicesViewModel

    typealias Services = HasApiProvider
    var services: HasApiProvider

    // MARK: Output
    let title: BehaviorRelay<String>
    let auth: BehaviorRelay<String>
    let bookCover: Observable<UIImage>

    // MARK: Definition Variable
    var book: Book

    required init(services: Services, book: Book) {
        self.services = services
        self.book = book

        title = BehaviorRelay<String>(value: book.title)
        auth = BehaviorRelay<String>(value: book.author)
        bookCover = Observable
            .just(book.coverImageUrl)
            .map { url in
                print(url)
                return url
            }
            .flatMap(services.apiProvider.getDetailAppgetBookCoverImage)
            .observeOn(MainScheduler.instance)
    }
}
