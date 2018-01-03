//
//  AppDelegate.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 8/5/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import UIKit
import Material

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barTintColor = .white
        let navigationController = UINavigationController(rootViewController: getInitialRootViewController())
        navigationController.navigationBar.isHidden = true
        window = UIWindow(frame: Screen.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        return true
    }

    func goToHome() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            let navigationController = UINavigationController(rootViewController: TabsViewController.getInstance())
            navigationController.navigationBar.isHidden = true
            self?.window!.rootViewController = navigationController
        }
    }

    private func getInitialRootViewController() -> UIViewController {
        if let _ = UserController.shared.getAuthToken() {
            return TabsViewController.getInstance()
        } else {
            return LoginViewController.getInstance()
        }
    }
}

