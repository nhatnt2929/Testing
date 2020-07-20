//
//  TabbarViewController.swift
//  MockingProject
//
//  Created by nhatnt on 7/13/20.
//  Copyright © 2020 eplus.epfs.ios. All rights reserved.
//

import UIKit
import Then

class PGTabBadge: UILabel {}

enum TabBarItemType: Int {
    case login
}

extension TabBarItemType {
    var selectedImage: UIImage? {
        return UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
    }
    
    var image: UIImage? {
        return UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
    }
    
    var title: String? {
        return "Login Tab"
    }
}

class TabBarController: UITabBarController {
    
    lazy var nowayNaviTab: UINavigationController = {
        let navi = UINavigationController()
        var nowayVc: LoginViewController = DefaultAssembler.shared.resolvedLoginVC(navi: navi)
        navi.do {
            $0.viewControllers = [nowayVc]
            $0.tabBarItem = UITabBarItem(title: TabBarItemType.login.title,
                                         image: TabBarItemType.login.image,
                                         selectedImage: TabBarItemType.login.selectedImage)
        }
        return navi
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    fileprivate func setUpTabbar() {
        setViewControllers([nowayNaviTab], animated: true)
        selectedIndex = 2
        view.backgroundColor = .white
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 0.5))
        tabBar.addSubview(lineView)
        
        tabBar.bringSubviewToFront(lineView)
        tabBar.do {
            $0.barTintColor = .white
            $0.layer.borderWidth = 0
            $0.clipsToBounds = true
        }
    }
}
