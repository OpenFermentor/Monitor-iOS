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

struct Routine {

    let id: Int
    let targetTemp: Double
    let targetPh: Double
    let targetDensity: Double
    let title: String
    let extraNotes: String?
    let duration: Double
    let strain: String
    let medium: String
    let insertedAt: Date

}

extension Routine: OperaDecodable, Decodable {

    static func decode(_ json: Any) throws -> Routine {
        return try! Routine(
            id: json => "id",
            targetTemp: json => "target_temp",
            targetPh: json => "target_ph",
            targetDensity: json => "target_density",
            title: json => "title",
            extraNotes: json =>? "extra_notes",
            duration: json => "estimated_time_seconds",
            strain: json => "strain",
            medium: json => "medium",
            insertedAt: DateInRegion(string: json => "inserted_at", format: .iso8601(options: .withInternetDateTimeExtended))!.absoluteDate
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
