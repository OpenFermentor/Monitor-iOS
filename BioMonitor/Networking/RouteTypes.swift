//
//  RouteTypes.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Alamofire
import Foundation
import OperaSwift

extension RouteType {

    var baseURL: URL { return Constants.Network.baseUrl }
    var manager: ManagerType { return ServiceManager.shared  }
    var retryCount: Int { return 0 }
    
}
