//
//  ServiceViewModelBased.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 13/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import Reusable

protocol ServicesViewModel: ViewModel {
    associatedtype Services
    var services: Services { get }
    init(services: Services)
}

protocol ServicesViewModelBased: class {
    associatedtype SercieViewModelType: ServicesViewModel
    var viewModel: SercieViewModelType! { get set }
    func configure(viewModel: SercieViewModelType)
    func setupViews()
}

extension ServicesViewModelBased where Self: UIViewController {
    static func instantiate<SercieViewModelType> (viewModel: SercieViewModelType)
        -> Self where SercieViewModelType == Self.SercieViewModelType {
            let viewController = Self(nibName: nil, bundle: nil)
            viewController.viewModel = viewModel
            return viewController
    }
}
