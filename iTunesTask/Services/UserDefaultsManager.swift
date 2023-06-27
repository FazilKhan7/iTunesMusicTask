//
//  UserDefaultsManager.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 24.06.2023.
//

import Foundation

class DataBase {
    
    static let shared = DataBase()
    
    enum SettingsKey: String {
        case users
        case activeUser
    }
    
    let defaults = UserDefaults.standard
    let userKey = SettingsKey.users.rawValue
    let activeUserKey = SettingsKey.activeUser.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            }else{
                return [User]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser(firstName: String, secondName: String, email: String, password: String, phone: String, age: Date) {
        let user = User(firstName: firstName, secondName: secondName, email: email, phoneNumber: phone, password: password, age: age)
        users.insert(user, at: 0)
    }
    
    var activeUser: User? {
        get {
            if let data = defaults.value(forKey: activeUserKey) as? Data {
                return try! PropertyListDecoder().decode(User.self, from: data)
            }else{
                return nil
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: activeUserKey)
            }
        }
    }
    
    func saveActiveUser(user: User) {
        activeUser = user
    }
}
