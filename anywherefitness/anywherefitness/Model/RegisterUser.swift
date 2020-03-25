//
//  RegisterUser.swift
//  anywherefitness
//
//  Created by patelpra on 3/24/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

struct RegisterUser: Codable {
    var username: String
    var password: String
    var firstName: String
    var lastName: String
    var email: String
    var roleId: UInt
}
