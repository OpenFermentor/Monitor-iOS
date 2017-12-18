//
//  RoutineCell.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/11/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import UIKit

class RoutineCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var strainLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var phLbl: UILabel!
    
    var routine: Routine? {
        didSet {
            updateData()
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func updateData() {
        guard let routine = routine else { return }
        titleLbl.text = routine.title
        strainLbl.text = "Cepa: \(routine.strain)"
        dateLbl.text = "Fecha: \(routine.insertedAt.string())"
        tempLbl.text = "\(routine.targetTemp) ºC"
        phLbl.text = "\(routine.targetPh)"
    }
    
}
