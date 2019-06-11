//
//  ViewController.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/15/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import SnapKit
import UIKit

class ViewController: UIViewController {

    let box: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(box)
        box.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.center.equalTo(view)
        }

        title = "Hello"

    }

}
