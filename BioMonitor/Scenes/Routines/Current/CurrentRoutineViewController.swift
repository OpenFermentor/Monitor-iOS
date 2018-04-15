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

    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var phLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var pumpsLbl: UILabel!
    @IBOutlet weak var tempContainer: UIView!
    @IBOutlet weak var phContainer: UIView!
    @IBOutlet weak var pumpsContainer: UIView!

    let channel = RoutineChannel.shared
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        prepareTabItem()
        bindToChannel()
    }

    func bindToChannel() {
        channel.status
            .asObservable().subscribe(
                onNext: { [unowned self] status in
                    guard let status = status else { return }
                    self.header.text = "En este momento no hay ningun experimento en proceso. Puede comenzar uno desde su equipo local"
                    self.titleLbl.text = "Estado del sistema"
                    self.tempLbl.text = status.temp ? "Conectado" : "Desconectado"
                    self.phLbl.text = status.ph ? "Conectado" : "Desconectado"
                    self.pumpsLbl.text = status.pumps ? "Conectadas" : "Desconectadas"
                    self.pumpsLbl.textColor = status.pumps ? Color.green.base : Color.amber.base
                    self.tempLbl.textColor = status.temp ? Color.green.base : Color.amber.base
                    self.phLbl.textColor = status.ph ? Color.green.base : Color.amber.base
                    self.pumpsContainer.isHidden = false
                }
            ).disposed(by: disposeBag)
        channel.update
            .asObservable().subscribe(
                onNext: { [unowned self] reading in
                    guard let reading = reading else { return }
                    self.titleLbl.text = "Experimento en proceso"
                    self.header.text = "Estas son las últimas lecturas registradas para el experimento"
                    self.pumpsContainer.isHidden = true
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
        tabItem.image = R.image.home()
    }
}
