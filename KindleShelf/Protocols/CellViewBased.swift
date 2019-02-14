//
//  CellView.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 13/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

protocol CellViewBased: class {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType { get set }

    func setupViews()
    func configure(viewModel: ViewModelType)
}

protocol ServiceCellViewBased: class {
    associatedtype ViewModelType: ServicesViewModel
    var viewModel: ViewModelType { get set }

    func configure(viewModel: ViewModelType)
}
