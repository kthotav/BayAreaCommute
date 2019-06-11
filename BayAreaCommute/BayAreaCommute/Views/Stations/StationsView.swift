//
//  StationsView.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/18/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import SnapKit
import UIKit

class StationsView: UIView {

    // MARK: - Subviews
    lazy var stationsTableView: UITableView = { return UITableView() }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("StationsView deinit")
    }
}

extension StationsView: CustomViewProtocol {

    func setupView() {
        addSubview(stationsTableView)
    }

    func setupConstraints() {
        stationsTableView.snp.makeConstraints {
            $0.edges.equalTo(self).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }

    }
}
