//
//  MoreView.swift
//  BayAreaCommute
//
//  Created by Karthik on 6/8/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import SnapKit
import UIKit

final class MoreView: UIView {

    // MARK: - Views
    lazy var moreTableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MoreView {

    private func setupView() {
        addSubview(moreTableView)
    }

    private func setupConstraints() {
        moreTableView.snp.makeConstraints {
            $0.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}
