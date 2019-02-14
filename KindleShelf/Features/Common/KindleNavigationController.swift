//
//  KindleNavigationController.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 14/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class KindleNavigationController: UINavigationController {

    let bag = DisposeBag()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {

        navigationBar.barTintColor = UIColor(red: 40 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1)
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let dividerColor = UIColor(red: 60 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)
        navigationBar.addBorders(edges: [.bottom], color: dividerColor, thickness: 0.8)
    }
}

extension KindleNavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
