//
//  ViewModel.swift
//  Instargram
//
//  Created by Lee on 2023/09/19.
//

import UIKit

class ViewModel {

    var userName: String = ""
    var userAge: Int = 0
    
    init(userName: String, userAge: Int) {
        self.userName = userName
        self.userAge = userAge
    }
    
    func updateUserInfo(userName: String, userAge: Int) {
        self.userName = userName
        self.userAge = userAge
    }
}

