//
//  BookCell.swift
//  KindleShelf
//
//  Created by SANGBONG MOON on 13/02/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BookCell: UITableViewCell {

    let bag = DisposeBag()

    private let bookCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        return imageView
    }()

    private let loadingIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .gray)
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the text for the title of out book inside of our cell"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the text for the title of out book inside of our cell"
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 1)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .clear
        selectedBackgroundView = selectedView
        addSubview(bookCoverImageView)
        addSubview(loadingIndicatorView)
        addSubview(titleLabel)
        addSubview(authorLabel)
    }

    func setupLayout() {

        bookCoverImageView.snp.makeConstraints { make in
            make.top.left.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(-8)
            make.width.equalTo(50)
        }

        loadingIndicatorView.snp.makeConstraints { make in
            make.center.equalTo(bookCoverImageView)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(bookCoverImageView.snp.right).offset(8)
            make.centerY.equalTo(self).offset(-10)
            make.right.equalTo(self).offset(-8)
            make.height.equalTo(20)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(bookCoverImageView.snp.right).offset(8)
            make.right.equalTo(self).offset(-8)
            make.height.equalTo(20)
        }
    }

    public func configure(viewModel: BookViewModel) {

        viewModel
            .title
            .bind(to: titleLabel.rx.text)
            .disposed(by: bag)

        viewModel
            .auth
            .bind(to: authorLabel.rx.text)
            .disposed(by: bag)

        viewModel
            .bookCover
            .map { image in
                self.loadingIndicatorView.stopAnimating()
                return image
            }.bind(to: bookCoverImageView.rx.image)
            .disposed(by: bag)

    }

}
