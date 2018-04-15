//
//  LoginViewController.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 12/24/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import UIKit
import RxSwift
import Material

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        stylize()
        loginBtn.addTarget(self, action: #selector(self.login), for: .touchUpInside)
    }

    @objc
    func login() {
        guard let email = emailTxt.text, let password = passwordTxt.text else { return }
        view.isUserInteractionEnabled = false
        loginBtn.setTitle("Cargando...", for: .normal)
        UserController.shared.login(email: email, password: password)
            .asObservable()
            .subscribe(
                onNext: { [unowned self] result in
                    guard let token = (result as? [String: Any])?["token"] as? String else {
                        self.errorLbl.text = "Hubo un error al autenticarse."
                        self.errorLbl.isHidden = false
                        return
                    }
                    UserController.shared.setAuthToken(token)
                    self.loginBtn.setTitle("Login", for: .normal)
                    self.errorLbl.isHidden = true
                    self.view.isUserInteractionEnabled = true
                    (UIApplication.shared.delegate as? AppDelegate)?.goToHome()
                },
                onError: { [unowned self] _ in
                    self.errorLbl.text = "Hubo un error al autenticarse."
                    self.errorLbl.isHidden = false
                    self.passwordTxt.text = nil
                    self.loginBtn.setTitle("Login", for: .normal)
                    self.view.isUserInteractionEnabled = true
                }
            ).disposed(by: disposeBag)
    }

    private func stylize() {
        loginBtn.layer.cornerRadius = 8
    }
}

extension LoginViewController {
    static func getInstance() -> LoginViewController {
        return R.storyboard.login.instantiateInitialViewController()!
    }
}
