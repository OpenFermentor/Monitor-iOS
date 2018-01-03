//
//  Status.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/8/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation

struct Status {
    let temp: Bool
    let pumps: Bool
    let ph: Bool

    static func from(data: [String: Any]) -> Status? {
        guard
            let temp = data["temp"] as? String,
            let pumps = data["pumps"] as? String,
            let ph = data["ph"] as? String
        else {
            return nil
        }
        return Status(temp: temp == "1", pumps: pumps == "1", ph: ph == "1")
    }
}
