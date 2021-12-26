//
//  ViewController.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

class SignInController: UIViewController {

    let signInView = SignInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = signInView
        addTargets()
        
    }
    
    func addTargets() {
        signInView.signInButton.addTarget(self,
                                          action: #selector(auth),
                                          for: .touchUpInside)
        signInView.showSignUpButton.addTarget(self,
                                              action: #selector(showSignUp),
                                              for: .touchUpInside)
        
    }
    
    @objc func auth() {
        
        AuthService.shared.login(email: signInView.emailTextField.text,
                                 password: signInView.passwordTextField.text) { result in
            switch result {
            case .success(let user):
                print(user.email)
                if AuthService.shared.currentUser?.uid == "hdppwnorqlPTEJYf86t1vUFrfhu1" {
                    let vc = MainAdminController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                } else {
                    let vc = TabBarController(userId: user.uid)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        

        
    }
    
    
    @objc func showSignUp() {
        let vc = SignUpController()
        self.present(vc, animated: true, completion: nil)
    }
}

