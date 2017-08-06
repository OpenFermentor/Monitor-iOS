//
//  TabsViewController.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Material

class TabsViewController: TabsController {

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
