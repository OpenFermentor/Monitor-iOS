//
//  Error.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 10/28/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation

struct BioMonitorError {
    let message: String
    let status: String?

    static func from(data: [String: Any]) -> BioMonitorError? {
        guard
            let message = data["message"] as? String
        else {
            return nil
        }
        return BioMonitorError(message: message, status: data["status"] as? String)
    }
}
