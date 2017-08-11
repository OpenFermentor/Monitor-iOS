//
//  Reading.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/8/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import SwiftDate

struct Reading {
    let temp: Double
    let ph: Double
    let density: Double
    let insertedAt: Date
    let routineId: Int
    let id: Int

    static func from(data: [String: Any]) -> Reading? {
        guard
            let temp = data["temp"] as? Double,
            let ph = data["ph"] as? Double,
            let density = data["density"] as? Double,
            let insertedAt = data["inserted_at"] as? String,
            let routineId = data["routine_id"] as? Int,
            let id = data["id"] as? Int,
            let date = DateInRegion(string: insertedAt, format: .iso8601(options: .withInternetDateTimeExtended))?.absoluteDate
        else {
            return nil
        }

        return Reading(temp: temp, ph: ph, density: density, insertedAt: date, routineId: routineId, id: id)
    }

}
