//
//  RoutineDetail.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/11/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import UIKit
import Material
import RxSwift

class RoutineDetailViewController: UIViewController {
    
    @IBOutlet weak var medium: UILabel!
    @IBOutlet weak var strain: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var ph: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var tempTolerance: UILabel!
    @IBOutlet weak var phTolerance: UILabel!
    @IBOutlet weak var detailStack: UIStackView!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var logContainer: LogView!
    @IBOutlet weak var reportContainer: UIView!

    private var disposeBag = DisposeBag()

    var routine: Routine!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        segmented.rx.value
            .asObservable()
            .subscribe(onNext: { [unowned self] value in
                self.selectedSectionChanged(index: value)
            })
            .disposed(by: disposeBag)
        logContainer.loadEntries(with: routine.id)
        stylize()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        switch id {
        case "report_segue":
            guard let vc = segue.destination as? RoutineReport else { return }
            vc.routineId = routine.id
        default:
            return
        }
    }

    private func stylize() {
        logContainer.isHidden = true
        title = routine.title
        medium.text = routine.medium
        strain.text = routine.strain
        temp.text = "\(routine.targetTemp)"
        ph.text = "\(routine.targetPh)"
        date.text = "\(routine.insertedAt.string())"
        notes.text = routine.extraNotes ?? "No hay notas"
        view.backgroundColor = .white
    }

    private func selectedSectionChanged(index: Int) {
        detailStack.isHidden = index != 0
        logContainer.isHidden = index != 1
        reportContainer.isHidden = index != 2
    }

}
