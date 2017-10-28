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

class CurrentRoutineViewController: UIViewController {

    @IBOutlet weak var densityLbl: UILabel!
    @IBOutlet weak var phLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tempContainer: UIView!
    @IBOutlet weak var phContainer: UIView!
    @IBOutlet weak var densityContainer: UIView!

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
                    guard let status = status else { return }
                    self.titleLbl.text = "Estado del sistema"
                    self.tempLbl.text = "\(status.temp) ºC"
                    self.phLbl.text = "\(status.ph) pH"
                    self.densityLbl.text = "\(status.density) g/l"
                }
            ).disposed(by: disposeBag)
        channel.update
            .asObservable().subscribe(
                onNext: { [unowned self] reading in
                    guard let reading = reading else { return }
                    self.titleLbl.text = "Experimento en proceso: \(reading.routineId)"
                    self.tempLbl.text = "\(reading.temp) ºC"
                    self.phLbl.text = "\(reading.ph) pH"
                    self.densityLbl.text = "\(reading.density) %"
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
