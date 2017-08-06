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
        static let baseUrl = URL(string:"http://localhost:4000")!
        static let socketUrl = URL(string: "http://localhost:4000/socket/websocket")!
    }
}
