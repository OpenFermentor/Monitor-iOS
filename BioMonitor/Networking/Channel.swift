//
//  Channel.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import Birdsong
import RxSwift

class RoutineChannel {

    static let shared = RoutineChannel()
    let socket = Socket(url: Constants.Network.socketUrl)
    var error = Variable<String?>(nil)
    var status = Variable<String?>(nil)
    var joinedRoutine = Variable<Bool>(false)
    var joinedSensors = Variable<Bool>(false)
    var alert = Variable<String?>(nil)
    var update = Variable<String?>(nil)
    var started = Variable<Bool>(false)

    init() {
        socket.onConnect = { [weak self] in
            guard let `self` = self else { return }
            self.connectToRoutineChannel()
            self.connectToStatusChannel()
        }

    }

    func connectToStatusChannel() {
        let channel = self.socket.channel("sensors")
        guard let join = channel.join() else {
            joinedSensors.value = false
            return
        }
        join.receive("ok") { payload in
            print("successfuly joined sensors channel")
            self.joinedSensors.value = true
        }
        join.receive("error") { payload in
            print("failed to join sensors channel")
            self.joinedSensors.value = false
            self.error.value = payload.description
        }
        channel.on("status") { status in
            print("Status received ============")
            print(status)
            print("============================")
            self.status.value = status.payload.description
        }
        channel.on("error") { error in
            print("Error received ============")
            print(error)
            print("============================")
            self.error.value = error.payload.description
        }
    }

    func connectToRoutineChannel() {
        let channel = self.socket.channel("routine")
        guard let join = channel.join() else {
            joinedRoutine.value = false
            return
        }
        join.receive("ok") { payload in
            print("successfuly joined routine channel")
            self.joinedRoutine.value = true
        }
        join.receive("error") { payload in
            print("failed to join routine channel")
            self.joinedRoutine.value = true
            self.error.value = payload.description
        }
        channel.on("update") { update in
            print("Update received ============")
            print(update)
            print("============================")
            self.update.value = update.payload.description
        }
        channel.on("started") { routine in
            print("Start received ============")
            print(routine)
            print("============================")
            self.started.value = true
        }
        channel.on("stopped") { routine in
            print("Stopped received ============")
            print(routine)
            print("============================")
            self.started.value = false
        }
        channel.on("alert") { alert in
            print("Alert received ============")
            print(alert)
            print("============================")
            self.alert.value = alert.payload.description
        }
    }
}
