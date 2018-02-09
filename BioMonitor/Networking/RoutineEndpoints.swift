//
//  RoutineEndpoints.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/11/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import OperaSwift
import RxSwift

struct RoutineEndpoints {

    struct Index: GetRouteType {
        let page: Int

        let path = "/routines"

        var parameters: [String : Any]? {
            return ["page": page]
        }
    }

    struct LogEntries: GetRouteType {
        let routineId: Int
        var path: String {
            return "/routines/\(routineId)/log_entries"
        }
    }

    struct Report: GetRouteType {
        let routineId: Int
        var path: String {
            return "/routines/\(routineId)/readings/calculations"
        }
    }

}

class RoutineController {

    static let shared = RoutineController()

    func index(page: Int) -> Single<RoutinePage> {
        return RoutineEndpoints.Index(page: page).rx.object()
    }

    func logEntries(routineId: Int) -> Single<[LogEntry]> {
        return RoutineEndpoints.LogEntries(routineId: routineId).rx.collection("data")
    }

    func report(routineId: Int) -> Single<Report> {
        return RoutineEndpoints.Report(routineId: routineId).rx.object("data")
    }

}
