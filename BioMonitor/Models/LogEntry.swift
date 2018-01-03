//
//  LogEntry.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 12/21/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import protocol Decodable.Decodable
import Decodable
import OperaSwift
import SwiftDate

struct LogEntry {
    let type: String
    let description: String
    let insertedAt: Date
}

extension LogEntry: OperaDecodable, Decodable {
    static func decode(_ json: Any) throws -> LogEntry {
        return try! LogEntry(
            type: json => "type",
            description: json => "description",
            insertedAt: DateInRegion(string: json => "inserted_at", format: .iso8601(options: .withInternetDateTimeExtended))!.absoluteDate
        )
    }
}
