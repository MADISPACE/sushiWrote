//
//  SignUpController.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

class SignUpController: UIViewController {
    
    let signUpView = SignUpView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = signUpView
        addTargets()
    }

    
    func addTargets() {
        
        signUpView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
    }
    
    @objc func signUp() {
        AuthService.shared.reg(email: signUpView.emailTextField.text,
                               password: signUpView.passwordTextField.text,
                               confirm: signUpView.confirmTextField.text) { result in
            
            switch result {
            case .success(let user):
                
                FirestoreService.shared.saveProfile(id: user.uid,
                                                    phone: nil,
                                                    name: nil,
                                                    imageUrl: nil,
                                                    address: nil) { result in
                    switch result {
                        
                    case .success(let customUser):
                        let vc = TabBarController(userId: customUser.id)
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    case .failure(let error):
                        print(error)
                        AuthService.shared.signOut()
                    }
                }
          
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
    }
    

}
