//
//  Routine.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/11/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import protocol Decodable.Decodable
import Decodable
import OperaSwift
import SwiftDate

struct Tag: OperaDecodable, Decodable {
    let value: String

    static func decode(_ json: Any) throws -> Tag {
        return try! Tag(value: json => "value")
    }
}

struct TempRange: OperaDecodable, Decodable {
    let temp: Double
    let fromSecond: Double

    static func decode(_ json: Any) throws -> TempRange {
        return try! TempRange(
            temp: json => "temp",
            fromSecond: json => "from_second"
        )
    }
}

struct Routine {

    let id: Int
    let uuid: String
    let targetTemp: Double
    let targetPh: Double
    let title: String
    let extraNotes: String?
    let duration: Double
    let strain: String
    let medium: String
    let insertedAt: Date
    let triggerFor: Int?
    let triggerAfter: Int?
    let tempTolerance: Double
    let phTolerance: Double
    let loopDelay: Int
    let balancePh: Bool
    let tags: [Tag]
    let tempRanges: [TempRange]
}

extension Routine: OperaDecodable, Decodable {

    static func decode(_ json: Any) throws -> Routine {
        return try! Routine(
            id: json => "id",
            uuid: json => "uuid",
            targetTemp: json => "target_temp",
            targetPh: json => "target_ph",
            title: json => "title",
            extraNotes: json =>? "extra_notes",
            duration: json => "estimated_time_seconds",
            strain: json => "strain",
            medium: json => "medium",
            insertedAt: DateInRegion(string: json => "inserted_at", format: .iso8601(options: .withInternetDateTimeExtended))!.absoluteDate,
            triggerFor: json =>? "trigger_for",
            triggerAfter: json =>? "trigger_after",
            tempTolerance: json => "temp_tolerance",
            phTolerance: json => "ph_tolerance",
            loopDelay: json => "loop_delay",
            balancePh: json => "balance_ph",
            tags: json => "tags",
            tempRanges: json => "temp_ranges"
        )
    }

}

struct PageInfo {
    let currentPage: String
    let maxPage: String
}

extension PageInfo: OperaDecodable, Decodable {
    static func decode(_ json: Any) throws -> PageInfo {
        return try! PageInfo(
            currentPage: json => "page",
            maxPage: json => "max_page"
        )
    }
}


struct RoutinePage {
    let routines: [Routine]
    let pageInfo: PageInfo
}

extension RoutinePage: OperaDecodable, Decodable {
    static func decode(_ json: Any) throws -> RoutinePage {
        return try! RoutinePage(
            routines: json => "data",
            pageInfo: json => "paginate"
        )
    }
}
