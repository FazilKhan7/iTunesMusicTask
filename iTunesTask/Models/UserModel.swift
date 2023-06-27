//
//  UserModel.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 24.06.2023.
//

import Foundation

struct User: Codable {
    let firstName: String
    let secondName: String
    let email: String
    let phoneNumber: String
    let password: String
    let age: Date
}
