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

    private let viewTypeSeamentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Cloud", "Device"])
        segmentControl.tintColor = .white
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()

    private let bottomBar: UIToolbar = {
        let toolbar = UIToolbar(frame: .zero)
        toolbar.barTintColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
        toolbar.isTranslucent = false
        return toolbar
    }()

    private let gridMenu: UIBarButtonItem = {
        let image = #imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        return item
    }()

    private let sortMenu: UIBarButtonItem = {
        let image = #imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal)
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
        view.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1)
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

        menuItem.rx.tap
            .bind { self.openMenu() }
            .disposed(by: bag)

        amazonItem.rx.tap
            .bind { self.openAmazonStore() }
            .disposed(by: bag)

        gridMenu.rx.tap
            .bind { self.changeGrid() }
            .disposed(by: bag)

        sortMenu.rx.tap
            .bind { self.sortItem() }
            .disposed(by: bag)

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
        view.addSubview(bottomBar)

        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let viewTypeItem = UIBarButtonItem(customView: viewTypeSeamentControl)

        bottomBar.setItems([gridMenu, flex, viewTypeItem, flex, sortMenu], animated: true)

    }

    func setupConstants() {

        bottomBar.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.height.equalTo(54)
            make.bottom.equalTo(self.view.snp_bottomMargin)
        }

        baseView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomBar.snp.top)
            make.top.left.right.equalTo(self.view)
        }
    }

    func setNavigation() {
        navigationItem.title = "Kindle"
        navigationItem.leftBarButtonItem = menuItem
        navigationItem.rightBarButtonItem = amazonItem
    }

    func openMenu() {
        print("open menu!")
    }

    func openAmazonStore() {
        print("open Amazon Store")
    }

    func changeGrid() {
        print("change Grid")
    }

    func sortItem() {
        print("sort Item!")
    }
}

extension ShelfViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
}
