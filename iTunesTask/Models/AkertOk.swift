//
//  AkertOk.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 24.06.2023.
//

import UIKit

extension UIViewController {
    
    func alert(title: String, message: String) {
        
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alertC.addAction(ok)
        
        present(alertC, animated: true)
    }
}
