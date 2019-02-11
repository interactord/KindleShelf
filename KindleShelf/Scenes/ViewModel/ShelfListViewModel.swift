//
//  ShelfListViewModel.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

protocol ShelfListViewModeling {
    // MARK: Input
    var startAction: PublishSubject<Void> { get }

    // MARK: Output
    var items: Observable<[Book]> { get }
}

final class ShelfListViewModel: ShelfListViewModeling {

    // MARK: Input

    let startAction = PublishSubject<Void>()

    // MARK: Output
    var items: Observable<[Book]>

    // MARK: Initializer

    typealias Service = HasApiProvider

    init(service: Service) {
        let start = startAction
            .flatMapLatest(service.apiProvider.getBookList)
            .observeOn(MainScheduler.instance)
            .share(replay: 1)

        items = start.map { $0 }

    }
}
