//
//  LogCell.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 12/21/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import UIKit
import Material

class LogCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    var logEntry: LogEntry? {
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
        guard let logEntry = logEntry else { return }
        titleLbl.text = titleForType(logEntry.type)
        titleLbl.textColor = colorForType(logEntry.type)
        descriptionLbl.text = logEntry.description
    }

    private func titleForType(_ type: String) -> String {
        switch type {
        case "reading_error":
            return "Lectura fuera de rango"
        case "base_cal":
            return "Balanceo de ph"
        case "acid_cal":
            return "Balanceo de ph"
        case "temp_change":
            return "Cambio de franja de temperatura"
        default:
            return "Error del sistema"
        }
    }

    private func colorForType(_ type: String) -> UIColor {
        switch type {
        case "reading_error":
            return Color.indigo.base
        case "base_cal":
            return Color.teal.base
        case "acid_cal":
            return Color.purple.base
        case "temp_change":
            return Color.deepOrange.base
        default:
            return Color.red.base
        }
    }
}
