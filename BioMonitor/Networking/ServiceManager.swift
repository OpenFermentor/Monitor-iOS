//
//  ServiceManager.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import OperaSwift
import Alamofire
import RxSwift


class ServiceManager: RxManager {

    static let shared = ServiceManager(manager: SessionManager.default)

    override init(manager: Alamofire.SessionManager) {
        super.init(manager: manager)

        observers = [Logger()]
        useMockedData = false
    }

}

struct Logger: OperaSwift.ObserverType {
    func willSendRequest(_ alamoRequest: Alamofire.Request, requestConvertible: URLRequestConvertible) {
        debugPrint(alamoRequest)
    }
}
