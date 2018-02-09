//
//  LogView.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 12/21/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Material
import Whisper

class LogView: UIView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    fileprivate var logEntries = [LogEntry]()
    private var disposeBag = DisposeBag()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.isHidden = true
        messageLabel.text = "No hay eventos registrados."
        tableView.backgroundColor = .white
        tableView.register(R.nib.logCell(), forCellReuseIdentifier: "log_entry_cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.allowsSelection = false
    }

    public func loadEntries(with routineId: Int) {
        RoutineController.shared.logEntries(routineId: routineId)
            .observeOn(MainScheduler.instance)
            .do(
                onNext: { [unowned self] logEntries in
                    Whisper.hide()
                    self.logEntries = logEntries
                    self.tableView.reloadData()
                    self.messageLabel.isHidden = self.logEntries.count != 0
                    self.tableView.isHidden = self.logEntries.count == 0
                    self.messageLabel.text = "No hay eventos registrados."
                },
                onError: { error in
                    self.messageLabel.text = "Hubo un error al conectarse al servidor."
                    self.messageLabel.isHidden = false
                    self.logEntries = []
                    self.tableView.reloadData()
                    self.tableView.isHidden = true
                }
            )
            .subscribe()
            .disposed(by: disposeBag)
    }
}

extension LogView: UITableViewDelegate { }

extension LogView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "log_entry_cell") as? LogCell else {
            return UITableViewCell()
        }
        cell.logEntry = logEntries[indexPath.row]
        return cell

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logEntries.count
    }
}
