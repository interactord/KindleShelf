//
//  ShelfViewModel.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 12/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

typealias BookSection = SectionModel<Void, BookViewModel>

protocol ShelfViewModelInput {
    var startAction: PublishRelay<Void> { get }
}

protocol ShelfViewModelOutput {
    var books: Observable<[BookSection]> { get }
}

typealias ShelfViewModelType = ShelfViewModelInput & ShelfViewModelOutput & ServicesViewModel

class ShelfViewModel: ShelfViewModelType {

    // MARK: ServicesViewModel
    typealias Services = HasApiProvider
    var services: HasApiProvider

    // MARK: Input

    let startAction = PublishRelay<Void>()

    // MARK: Output

    var books: Observable<[BookSection]>

    // MARK: Initializer

    required init(services: Services) {
        self.services = services

        let start = startAction
            .flatMapLatest(services.apiProvider.getBookList)
            .observeOn(MainScheduler.instance)
            .share(replay: 1)

        books = start.map { books in
            let sectionItems = books.map { book in
                BookViewModel(services: services, book: book)
            }

            return [BookSection(model: Void(), items: sectionItems)]
        }
    }

}
