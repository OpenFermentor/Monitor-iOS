//
//  Constants.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation

struct Constants {
    struct Network {
        static let baseUrl = URL(string:"https://bio-monitor-staging.herokuapp.com/api")!
        static let socketUrl = URL(string: "https://bio-monitor-staging.herokuapp.com/socket/websocket")!
//        static let baseUrl = URL(string:"http://localhost:2000/api")!
//        static let socketUrl = URL(string: "http://localhost:2000/socket/websocket")!
    }

    struct Auth {
        static let authHeader = "access-token"
        static let authKey = "com.open.fermentor.auth"
    }
}
