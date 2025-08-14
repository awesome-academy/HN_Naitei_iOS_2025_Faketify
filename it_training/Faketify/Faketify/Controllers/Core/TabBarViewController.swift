//
//  TabBarViewController.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/7/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.forEach {
            if let nav = $0 as? UINavigationController {
                nav.navigationBar.prefersLargeTitles = true
                nav.topViewController?.navigationItem.largeTitleDisplayMode = .always
            }
        }
    }
}
