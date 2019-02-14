//
//  KindleNavigationController.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 14/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class KindleNavigationController: UINavigationController {

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
    }
}
