//
//  ViewModelBased.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 12/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import Reusable

protocol ViewModelBased: class {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType { get set }
}

extension ViewModelBased where Self: UIViewController {
    static func instantiate<ViewModelType> (viewModel: ViewModelType)
        -> Self where ViewModelType == Self.ViewModelType {
            let viewController = Self(nibName: nil, bundle: nil)
            viewController.viewModel = viewModel
            return viewController
    }
}
