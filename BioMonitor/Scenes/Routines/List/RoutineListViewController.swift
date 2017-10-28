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

class RoutineListViewController: UIViewController {

    @IBOutlet weak var newRoutineBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()

    fileprivate var routines = [Routine]()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabItem()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.routineCell(), forCellReuseIdentifier: "routine_cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.allowsSelection = true
        // TODO: For now, until this feature is ready
        newRoutineBtn.isHidden = true
        fetchRoutines()
    }

    func showDetail(routine: Routine) {

    }

    func fetchRoutines() {
        RoutineController.shared.index().subscribe(
            onSuccess: { [unowned self] routines in
                self.routines = routines
                self.tableView.reloadData()
            },
            onError: { error in
                print("========================error")
            }
        ).disposed(by: disposeBag)
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
        tabItem.image = R.image.ic_view_list()
    }
}
