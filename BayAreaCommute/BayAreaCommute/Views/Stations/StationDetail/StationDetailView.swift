//
//  StationDetailView.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/21/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import SnapKit
import UIKit

class StationDetailView: UIView {

    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tbv = UITableView(frame: .zero, style: .grouped)
        return tbv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StationDetailView: CustomViewProtocol {

    func setupView() {
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}
