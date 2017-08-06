//
//  ViewController.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/5/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import UIKit
import Material

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    fileprivate func prepareTabItem() {
        tabItem.title = "First"
        tabItem.titleColor = Color.blueGrey.base
    }
}

