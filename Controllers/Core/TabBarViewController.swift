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
        if let existing = viewControllers, existing.isEmpty == false {
            existing.compactMap { $0 as? UINavigationController }.forEach { nav in
                nav.navigationBar.tintColor = .label
                nav.navigationBar.prefersLargeTitles = true
                if let root = nav.viewControllers.first {
                    if root is HomeViewController {
                        nav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
                    } else if root is SearchViewController {
                        nav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
                    } else if root is LibraryViewController {
                        nav.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
                    }
                }
            }
        } else {
            let vc1 = HomeViewController()
            let vc2 = SearchViewController()
            let vc3 = LibraryViewController()
            vc1.title = "Browse"
            vc2.title = "Search"
            vc3.title = "Library"
            let nav1  = UINavigationController(rootViewController: vc1)
            let nav2  = UINavigationController(rootViewController: vc2)
            let nav3  = UINavigationController(rootViewController: vc3)
            [nav1, nav2, nav3].forEach { nav in
                nav.navigationBar.tintColor = .label
                nav.navigationBar.prefersLargeTitles = true
            }
            nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
            nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
            nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
            setViewControllers([nav1, nav2, nav3], animated: true)
        }
    }
}
