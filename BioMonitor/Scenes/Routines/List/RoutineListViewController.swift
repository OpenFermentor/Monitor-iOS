//
//  RoutineListViewController.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/6/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import Material
import RxSwift
import Whisper

class RoutineListViewController: UIViewController {

    @IBOutlet weak var newRoutineBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()

    fileprivate var routines = [Routine]()
    fileprivate var currentPage = 0
    fileprivate var nextPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabItem()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.routineCell(), forCellReuseIdentifier: "routine_cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.allowsSelection = true
        tableView.contentOffset.y = 0
        newRoutineBtn.isHidden = true
        tableView.rx.reachedBottom.subscribe(onNext: { [unowned self] _ in
            self.fetchRoutines()
        }).disposed(by: disposeBag)
        fetchRoutines()
    }


    func fetchRoutines() {
        guard currentPage < nextPage else { return }
        RoutineController.shared.index(page: nextPage)
            .observeOn(MainScheduler.instance)
            .do(
                onNext: { [unowned self] routinePage in
                    Whisper.hide()
                    guard
                        let currentPage = Int(routinePage.pageInfo.currentPage),
                        let maxPage = Int(routinePage.pageInfo.maxPage)
                    else { return }
                    routinePage.routines.forEach { self.routines.append($0) }
                    if currentPage < maxPage {
                        self.nextPage = currentPage + 1
                        self.currentPage = currentPage
                    }
                    self.tableView.reloadData()
                },
                onError: { error in
                    let announcement = Announcement(title: "Error", subtitle: "No se pudo conectar con el servidor", image: nil, duration: 180)
                    Whisper.show(shout: announcement, to: self)
                }
            )
            .subscribe()
            .disposed(by: disposeBag)
    }
    
}

extension RoutineListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let routine = routines[indexPath.row]
        guard let vc = R.storyboard.routineDetail.instantiateInitialViewController() else { return }
        vc.routine = routine
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension RoutineListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "routine_cell") as? RoutineCell else {
            return UITableViewCell()
        }
        cell.routine = routines[indexPath.row]
        return cell

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routines.count
    }
}

extension RoutineListViewController {

    static func getInstance() -> RoutineListViewController {
        return R.storyboard.routineList.instantiateInitialViewController()!
    }

    fileprivate func prepareTabItem() {
        tabItem.titleColor = Color.blueGrey.base
        tabItem.image = R.image.beaker()
    }
}
