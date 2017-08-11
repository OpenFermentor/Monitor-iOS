//
//  Status.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/8/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation

struct Status {
    let temp: Double
    let density: Double
    let ph: Double

    static func from(data: [String: Any]) -> Status? {
        guard
            let temp = data["temp"] as? Double,
            let density = data["density"] as? Double,
            let ph = data["ph"] as? Double
        else {
            return nil
        }
        return Status(temp: temp, density: density, ph: ph)
    }
}
