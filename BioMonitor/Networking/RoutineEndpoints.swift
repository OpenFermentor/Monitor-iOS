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
        let path = "/routines"
    }

}

class RoutineController {

    static let shared = RoutineController()

    func index() -> Single<[Routine]> {
        return RoutineEndpoints.Index().rx.collection("data")
    }

}
