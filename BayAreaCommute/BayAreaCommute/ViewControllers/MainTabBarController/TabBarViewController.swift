//
//  TabBarViewController.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/15/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - View Controllers
    let stationsVC: NavigationViewController = {
        let stationsVC = NavigationViewController(rootViewController: StationsViewController())
        stationsVC.tabBarItem = UITabBarItem(title: "Stations", image: #imageLiteral(resourceName: "StationTabBarItem"), selectedImage: nil)
        return stationsVC
    }()

    let moreVC: NavigationViewController = {
        let moreVC = NavigationViewController(rootViewController: MoreViewController())
        moreVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        return moreVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        viewControllers = [stationsVC, moreVC]
    }

}

extension TabBarViewController {
    private func setupTabBar() {
        tabBar.tintColor = UIColor(named: "Pink")
    }
}
