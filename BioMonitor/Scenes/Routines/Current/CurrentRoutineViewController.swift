//
//  CurrentRoutineViewController.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import Material
import Charts

class CurrentRoutineViewController: UIViewController {

    @IBOutlet weak var chartView: LineChart!
    let channel = RoutineChannel.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabItem()
        chartView.setup()

    }
}

extension CurrentRoutineViewController {

    static func getInstance() -> CurrentRoutineViewController {
        return R.storyboard.currentRoutine.instantiateInitialViewController()!
    }

    fileprivate func prepareTabItem() {
        tabItem.titleColor = Color.blueGrey.base
        tabItem.image = R.image.ic_graphic_eq()
    }
}
