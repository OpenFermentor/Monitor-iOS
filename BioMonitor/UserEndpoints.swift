//
//  UserEndpoints.swift
//  BioMonitor
//
//  Created by Mauricio Cousillas on 12/24/17.
//  Copyright © 2017 Open Fermentor. All rights reserved.
//

import Foundation
import OperaSwift
import RxSwift

struct UserEndpoints {
    
    struct Login: PostRouteType {
        let email: String
        let password: String
        let path = "/sessions/login"

        var parameters: [String : Any]? {
            return ["user":
                [
                    "email": email,
                    "password": password
                ]
            ]
        }
    }

}

class UserController {

    static let shared = UserController()

    func login(email: String, password: String) -> Single<Any> {
        return UserEndpoints.Login(email: email, password: password).rx.any()
    }


    public func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: Constants.Auth.authKey)
    }

    public func setAuthToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: Constants.Auth.authKey)
    }

}
