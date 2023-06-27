//
//  AuthViewController.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 23.06.2023.
//

import Foundation
import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter email"
        textField.autocorrectionType = .no
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        button.setTitle("Sign up", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Sign in", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var textFieldsStackView = UIStackView()
    private var buttonsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstraints()
        registerKeyboardNotification()
    }
    
    private func setupViews() {
        title = "SignIn"
        view.backgroundColor = .white
        
        textFieldsStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField],
                                          axis: .vertical,
                                          spacing: 10,
                                          distribution: .fillProportionally)
        
        buttonsStackView = UIStackView(arrangedSubviews: [signInButton, signUpButton],
                                       axis: .horizontal,
                                       spacing: 10,
                                       distribution: .fillEqually)
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(textFieldsStackView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(buttonsStackView)
    }
    
    private func setupDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc private func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
    
    @objc private func signInButtonTapped() {
        
        let mail = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        let user = findUserFromDataBase(mail: mail)

        if user == nil {
            loginLabel.text = "User not found"
            loginLabel.textColor = .red
        }else if user?.password == password && user?.email == mail {
            let navVC = UINavigationController(rootViewController: AlbumsViewController())
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)

            guard let activeUser = user else { return }
            DataBase.shared.saveActiveUser(user: activeUser)

        }else {
            loginLabel.text = "Password is not correct"
            loginLabel.textColor = .red
        }
    }
}


extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

extension AuthViewController {
    
    private func registerKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    private func findUserFromDataBase(mail: String) -> User? {
        let dataBase = DataBase.shared.users
        
        for user in dataBase {
            if user.email == mail {
                return user
            }
        }
        return nil
    }
}

extension AuthViewController {
    
    private func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.centerY.equalTo(scrollView.snp.centerY)
            make.centerX.equalTo(scrollView.snp.centerX)
            
            make.height.equalTo(view.snp.height)
            make.width.equalTo(view.snp.width)
        }
        
        textFieldsStackView.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.centerY.equalTo(backgroundView.snp.centerY)
            
            make.leading.equalTo(backgroundView.snp.leading).offset(12)
            make.trailing.equalTo(backgroundView.snp.trailing).offset(-12)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalTo(backgroundView.snp.centerX)
            make.bottom.equalTo(textFieldsStackView.snp.top).offset(-30)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView.snp.leading).offset(20)
            make.trailing.equalTo(backgroundView.snp.trailing).offset(-20)
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(30)
        }
    }
}
