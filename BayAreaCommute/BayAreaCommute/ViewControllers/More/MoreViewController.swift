//
//  MoreViewController.swift
//  BayAreaCommute
//
//  Created by Karthik on 6/8/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

final class MoreViewController: UIViewController {

    // MARK: - Views
    lazy var moreView: MoreView = {
        let moreView = MoreView()
        moreView.moreTableView.dataSource = self
        return moreView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = moreView
    }
}

extension MoreViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "hello"
        return cell
    }

}
