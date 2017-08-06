//
//  RoutineListViewController.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import Material

class RoutineListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabItem()
        view.backgroundColor = Material.Color.blueGrey.base
    }
    
}

extension RoutineListViewController {

    static func getInstance() -> RoutineListViewController {
        return RoutineListViewController()
    }

    fileprivate func prepareTabItem() {
        tabItem.titleColor = Color.blueGrey.base
        tabItem.image = R.image.ic_view_list()
    }
}
