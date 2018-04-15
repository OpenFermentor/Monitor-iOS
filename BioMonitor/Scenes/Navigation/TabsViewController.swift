//
//  TabsViewController.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Material

class TabsViewController: TabsController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            tabBar.frame.origin.y -= view.safeAreaInsets.bottom
        }
    }

    open override func prepare() {
        super.prepare()
        tabBar.lineColor = Material.Color.blueGrey.base
    }

}

extension TabsViewController {

    static func getInstance() -> TabsViewController {
        return TabsViewController(
            viewControllers: [
                CurrentRoutineViewController.getInstance(),
                RoutineListViewController.getInstance()
            ],
            selectedIndex: 0
        )
    }

}
