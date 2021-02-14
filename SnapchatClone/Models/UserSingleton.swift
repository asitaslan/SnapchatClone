//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Asit Aslan on 14.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var userName = ""
    
    
    private init(){
        
    }
    
}
