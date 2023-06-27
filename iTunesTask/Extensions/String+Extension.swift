//
//  String+Extension.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 24.06.2023.
//

import Foundation

extension String {
    
    enum ValidTypes {
        case name
        case email
        case phone
        case password
    }
    
    enum Regex: String {
        case name = "[a-zA-Z]{1,}"
        case email = "[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
        case phone = "[0-9]{5,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
    }
    
    func isValid(validTypes: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validTypes {
        case .name: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
        case .phone: regex = Regex.phone.rawValue
        case .password: regex = Regex.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
