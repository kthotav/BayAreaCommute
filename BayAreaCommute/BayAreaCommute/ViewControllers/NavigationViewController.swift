//
//  NavigationViewController.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/18/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = UIColor(named: "Pink")
    }

}
