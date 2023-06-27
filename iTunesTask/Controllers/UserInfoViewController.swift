//
//  UserInfoViewController.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 23.06.2023.
//

import Foundation
import UIKit

class UserInfoViewController: UIViewController {
    
    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var line1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.view.layer.frame.width - 70).isActive = true
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private lazy var secondNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Second Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var line2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.view.layer.frame.width - 70).isActive = true
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var line3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.view.layer.frame.width - 70).isActive = true
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var line4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.view.layer.frame.width - 70).isActive = true
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var line5: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.view.layer.frame.width - 70).isActive = true
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var line6: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.view.layer.frame.width - 70).isActive = true
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    private lazy var stackView = UIStackView()
    private lazy var imagesStackView = UIStackView()
        
    private lazy var firstNameIcon = UIButton()
    private lazy var lastNameIcon = UIButton()
    private lazy var ageIcon = UIButton()
    private lazy var emailIcon = UIButton()
    private lazy var passwordIcon = UIButton()
    private lazy var phoneNumberIcon = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setModel()
        setButtonsImage()
    }
    
    private func setupViews() {
        title = "Active User"
        view.backgroundColor = .white
        
        stackView = UIStackView(arrangedSubviews: [firstNameLabel,
                                                   secondNameLabel,
                                                   ageLabel,
                                                   phoneLabel,
                                                   emailLabel,
                                                   passwordLabel],
                                axis: .vertical,
                                spacing: 35,
                                distribution: .fillProportionally)
        
        imagesStackView = UIStackView(arrangedSubviews: [firstNameIcon,
                                                         lastNameIcon,
                                                         ageIcon,
                                                         emailIcon,
                                                         passwordIcon,
                                                         phoneNumberIcon
                                                        ],
                                      axis: .vertical,
                                      spacing: 33,
                                      distribution: .fillProportionally)
        
        
        [stackView, imagesStackView, line1, line2, line3, line4, line5, line6].forEach {
            view.addSubview($0)
        }
    }
    
    private func setModel() {
        guard let activeUser = DataBase.shared.activeUser else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: activeUser.age)
        
        firstNameLabel.text = activeUser.firstName
        secondNameLabel.text = activeUser.secondName
        ageLabel.text = dateString
        emailLabel.text = activeUser.email
        passwordLabel.text = activeUser.password
        phoneLabel.text = activeUser.phoneNumber
    }
    
    private func setButtonsImage() {
        firstNameIcon.setImage(UIImage(systemName: "person.fill"), for: .normal)
        firstNameIcon.tintColor = .gray
        lastNameIcon.setImage(UIImage(systemName: "person.fill"), for: .normal)
        lastNameIcon.tintColor = .gray
        ageIcon.setImage(UIImage(systemName: "calendar"), for: .normal)
        ageIcon.tintColor = .gray
        emailIcon.setImage(UIImage(systemName: "envelope.fill"), for: .normal)
        emailIcon.tintColor = .gray
        passwordIcon.setImage(UIImage(systemName: "lock.fill"), for: .normal)
        passwordIcon.tintColor = .gray
        phoneNumberIcon.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        phoneNumberIcon.tintColor = .gray
    }
}

//MARK: - SetConstraints

extension UserInfoViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            line1.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 17),
            line1.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            line2.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 17),
            line2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            line3.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 17),
            line3.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            line4.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 17),
            line4.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            line5.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 17),
            line5.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            line6.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 17),
            line6.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: imagesStackView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            imagesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            imagesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }
}
