//
//  ShelfViewController.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 12/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

class ShelfViewController: UIViewController, ServicesViewModelBased {

    // MARK: Definition Variable

    private let baseView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        return tableView
    }()

    private let menuItem: UIBarButtonItem = {
        let image = #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        return item
    }()

    private let amazonItem: UIBarButtonItem = {
        let image = #imageLiteral(resourceName: "amazon_icon").withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        return item
    }()

    typealias ServiceViewModelType = ShelfViewModel

    var viewModel: ShelfViewModel!

    let bag = DisposeBag()

    var dataSource: RxTableViewSectionedReloadDataSource<BookSection>?

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
        register()
        setNavigation()
        setupViews()
        setupConstants()
        configure(viewModel: viewModel)
    }

    // MARK: Binding

    func configure(viewModel: ShelfViewModel) {
        viewWillAppearTrigger
            .bind(to: viewModel.startAction)
            .disposed(by: bag)

        if let dataSource = dataSource {
            viewModel
                .books
                .bind(to: baseView.rx.items(dataSource: dataSource))
                .disposed(by: bag)
        }

    }

    func register() {
        baseView.register(BookCell.self, forCellReuseIdentifier: "bookCell")

        let dataSource = RxTableViewSectionedReloadDataSource<BookSection> (configureCell: { _, tableView, indexPath, item -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
            let item = item
            if let cell = cell as? BookCell {
                cell.configure(viewModel: item)
            }

            return cell
        })

        self.dataSource = dataSource

        baseView.rx.setDelegate(self).disposed(by: bag)
    }

    func setupViews() {
        view.addSubview(baseView)
    }

    func setupConstants() {
        baseView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(self.view)
        }
    }

    func setNavigation() {
        navigationItem.title = "Kindle"
        navigationItem.leftBarButtonItem = menuItem
        navigationItem.rightBarButtonItem = amazonItem

        navigationController?.navigationBar.barTintColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let dividerColor = UIColor(red: 60 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)
        navigationController?.navigationBar.addBorders(edges: [.bottom], color: dividerColor, thickness: 0.8)
    }
}

extension ShelfViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}
