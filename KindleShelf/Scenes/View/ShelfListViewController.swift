//
//  ShelfListViewController.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 10/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class ShelfListViewController: UIViewController {

    let bag = DisposeBag()

    var viewModel: ShelfListViewModeling?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .red
        setupInputBinding()
        setupOutputBinding()

    }

    func setupInputBinding() {
        guard let viewModel = viewModel else { return }

        viewWillAppearTrigger
            .bind(to: viewModel.startAction)
            .disposed(by: bag)
    }

    func setupOutputBinding() {
        guard let viewModel = viewModel else { return }
        viewModel.items.subscribe(onNext: { books in
            print(books)
        })
        .disposed(by: bag)
    }
}
