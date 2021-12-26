//
//  SignInView.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

class SignInView: UIView {

    let roundView = UIView()
    let rectView = UIView()
    let imageView = UIImageView(image: UIImage(named: "logoSushi"))
    let signInLabel = UILabel(text: "Sign In", font: FontsLibrary.smallTitle)
    let emailTextField = UITextField(placeholder: "Email")
    let passwordTextField = UITextField(placeholder: "Password")
    let signInButton = UIButton(title: "Sign In",
                                bgColor: ColorsLibrary.redButton,
                                textColor: .white,
                                font: FontsLibrary.fieldButton)
    let showSignUpButton = UIButton(title: "Go to sign Up",
                                    bgColor: .clear,
                                    textColor: ColorsLibrary.darkGreen,
                                    font: FontsLibrary.smallButton)
    
    init() {
        super.init(frame: CGRect())
        
        setViews()
        setConstraints()
    }
    
    //Отвечает за внешний вид элементов интерфейса
    func setViews() {
        backgroundColor = ColorsLibrary.lightGreen
        rectView.backgroundColor = .white
        rectView.layer.cornerRadius = 16
        roundView.layer.cornerRadius = 60
        roundView.backgroundColor = .white
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        signInLabel.textAlignment = .center
        signInLabel.textColor = ColorsLibrary.darkGreen
        passwordTextField.isSecureTextEntry = true
    }
    
    //Отвечает за положение элементов на экране
    func setConstraints() {
        
        let stack = UIStackView(views: [signInLabel,
                                        emailTextField,
                                        passwordTextField,
                                        signInButton,
                                        showSignUpButton],
                                axis: .vertical,
                                spacing: 18)
        
        //1. Выстроить иерархию Views, т.е. добавить сабвью
        Helper.addSub(views: [rectView, roundView], to: self)
        Helper.addSub(views: [imageView], to: roundView)
        Helper.addSub(views: [stack], to: rectView)
        
        
        //2. Отключить авторесайзинг
        Helper.tamicOff(views: [rectView, roundView, imageView, stack])
        
        //3. Настроить констрейнты
        
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: roundView.bottomAnchor, constant: 12),
                                     stack.leadingAnchor.constraint(equalTo: rectView.leadingAnchor, constant: 24),
                                     stack.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     stack.bottomAnchor.constraint(equalTo: rectView.bottomAnchor, constant: -24)])
        
        NSLayoutConstraint.activate([imageView.heightAnchor.constraint(equalToConstant: 100),
                                     imageView.widthAnchor.constraint(equalToConstant: 100),
                                     imageView.centerYAnchor.constraint(equalTo: roundView.centerYAnchor, constant: -7),
                                     imageView.centerXAnchor.constraint(equalTo: roundView.centerXAnchor, constant: -5)])
    
        NSLayoutConstraint.activate([rectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
                                     rectView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     rectView.heightAnchor.constraint(equalToConstant: 360),
                                     rectView.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
        
        NSLayoutConstraint.activate([roundView.heightAnchor.constraint(equalToConstant: 120),
                                     roundView.widthAnchor.constraint(equalToConstant: 120),
                                     roundView.centerXAnchor.constraint(equalTo: rectView.centerXAnchor),
                                     roundView.centerYAnchor.constraint(equalTo: rectView.topAnchor)])
        
        let views = [emailTextField,
                     passwordTextField,
                     signInButton,
                     showSignUpButton]
        
        for view in views {
            NSLayoutConstraint.activate([view.heightAnchor.constraint(equalToConstant: 40)])
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
