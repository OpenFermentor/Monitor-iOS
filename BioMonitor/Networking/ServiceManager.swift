//
//  ServiceManager.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Alamofire
import Foundation
import OperaSwift

final class ServiceManager: RxManager {

    public static let shared: ServiceManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return ServiceManager(manager: sessionManager)
    }()

    public override init(manager: Alamofire.SessionManager) {
        super.init(manager: manager)
        observers = [Logger()]
    }

}

public struct Logger: OperaSwift.ObserverType {

    public func willSendRequest(_ alamoRequest: Alamofire.Request, requestConvertible: URLRequestConvertible) {
        debugPrint(alamoRequest)
    }
    
}
