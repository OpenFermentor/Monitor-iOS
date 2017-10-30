//
//  CurrentRoutineViewController.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import Material
import Charts
import RxSwift
import Whisper

class CurrentRoutineViewController: UIViewController {

    @IBOutlet weak var phLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tempContainer: UIView!
    @IBOutlet weak var phContainer: UIView!

    let channel = RoutineChannel.shared
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabItem()
        bindToChannel()
    }

    func bindToChannel() {
        channel.status
            .asObservable().subscribe(
                onNext: { [unowned self] status in
                    guard let _ = status else { return }
                    self.titleLbl.text = "Estado del sistema"
                    self.tempLbl.text = "En funcionamiento"
                    self.phLbl.text = "En funcionamiento"
                }
            ).disposed(by: disposeBag)
        channel.update
            .asObservable().subscribe(
                onNext: { [unowned self] reading in
                    guard let reading = reading else { return }
                    self.titleLbl.text = "Experimento en proceso: \(reading.routineId)"
                    self.tempLbl.text = "\(reading.temp) ºC"
                    self.phLbl.text = "\(reading.ph) pH"
                }
            ).disposed(by: disposeBag)
        channel.alert
            .asObservable().subscribe(
                onNext: { [unowned self] alert in
                    guard let alert = alert else { return }
                    let announcement = Announcement(title: "Error", subtitle: alert.message, image: nil, duration: 60)
                    Whisper.show(shout: announcement, to: self)
                }
            ).disposed(by: disposeBag)
        channel.error
            .asObservable().subscribe(
                onNext: { [unowned self] error in
                    guard let error = error else { return }
                    let announcement = Announcement(title: "Error del sistema", subtitle: error.message, image: nil, duration: 60)
                    Whisper.show(shout: announcement, to: self)
                }
            ).disposed(by: disposeBag)
        channel.instruction
            .asObservable().subscribe(
                onNext: { [unowned self] instruction in
                    let alert = UIAlertController(title: "Nueva instrucción", message: instruction, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                }
        ).disposed(by: disposeBag)
    }

}

extension CurrentRoutineViewController {

    static func getInstance() -> CurrentRoutineViewController {
        return R.storyboard.currentRoutine.instantiateInitialViewController()!
    }

    fileprivate func prepareTabItem() {
        tabItem.titleColor = Color.blueGrey.base
        tabItem.image = R.image.ic_graphic_eq()
    }
}
