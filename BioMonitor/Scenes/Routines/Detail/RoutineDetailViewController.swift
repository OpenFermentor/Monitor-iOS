//
//  RoutineDetail.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/11/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import UIKit
import Material

class RoutineDetailViewController: UIViewController {
    
    @IBOutlet weak var medium: UILabel!
    @IBOutlet weak var strain: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var ph: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var notes: UITextView!


    var routine: Routine!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        title = routine.title
        medium.text = routine.medium
        strain.text = routine.strain
        temp.text = "\(routine.targetTemp)"
        ph.text = "\(routine.targetPh)"
        date.text = "\(routine.insertedAt.string())"
        notes.text = routine.extraNotes ?? ""
        notes.layer.borderColor = Material.Color.blueGrey.base.cgColor
        notes.layer.borderWidth = 1
        notes.layer.cornerRadius = 5
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}
