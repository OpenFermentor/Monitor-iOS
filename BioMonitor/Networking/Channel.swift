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
    var statusChannel: Channel?
    var routineChannel: Channel?
    var error = Variable<String?>(nil)
    var status = Variable<Status?>(nil)
    var joinedRoutine = Variable<Bool>(false)
    var joinedSensors = Variable<Bool>(false)
    var alert = Variable<String?>(nil)
    var update = Variable<Reading?>(nil)
    var started = Variable<Bool>(false)
    var lastReadings = Variable<[Reading]>([])

    init() {
        socket.onConnect = { [weak self] in
            guard let `self` = self else { return }
            self.connectToRoutineChannel()
            self.connectToStatusChannel()
        }
        socket.connect()
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
            guard let newStatus = Status.from(data: status.payload) else {
                self.status.value = nil
                return
            }
            self.status.value = newStatus
        }
        channel.on("error") { error in
            print("Error received ============")
            print(error)
            print("============================")
            self.error.value = error.payload.description
        }
        statusChannel = channel
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
            guard let reading = Reading.from(data: update.payload) else {
                self.status.value = nil
                return
            }
            self.update.value = reading
            self.addReading(reading: reading)
        }
        channel.on("started") { routine in
            self.lastReadings.value = []
            self.started.value = true
        }
        channel.on("stopped") { routine in
            self.lastReadings.value = []
            self.started.value = false
        }
        channel.on("alert") { alert in
            print("Alert received ============")
            print(alert)
            print("============================")
            self.alert.value = alert.payload.description
        }
        routineChannel = channel
    }

    func addReading(reading: Reading) {
        var readings = lastReadings.value
        if readings.count >= 20 {
            readings.remove(at: 0)
        }
        readings.append(reading)
        lastReadings.value = readings
    }
}
