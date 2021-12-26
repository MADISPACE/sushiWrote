//
//  ProfileController.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import UIKit

protocol ProfileDelegate {
    
    func updateViews()
}

class ProfileController: UIViewController, UINavigationControllerDelegate {

    let profileView = ProfileView()
    var customUser: CustomUser
    var orders = [Order]()
    
    init(customUser: CustomUser) {
        self.customUser = customUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        addTargets()
        setupView()
        print(customUser.phone)
        addTapToDismissKeyboard()
        profileView.nameTextField.delegate = self
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        getOrders()
        downloadAvatar()
    }
    
    func getOrders() {
        FirestoreService.shared.getOrders(by: customUser.id) { result in
            switch result {
                
            case .success(let orders):
                self.orders = orders
                self.profileView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func downloadAvatar() {
        
        StorageService.shared.downloadPhoto(url: customUser.imageUrl) { result in
            switch result {
                
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    return
                }
                self.profileView.avatar.image = image
                        
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func getProfile() {
        
        FirestoreService.shared.getProfile(id: AuthService.shared.currentUser!.uid) { result in
            switch result {
                
            case .success(let user):
                self.customUser = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func addTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
 
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupView() {
        profileView.addressLabel.text = customUser.address
        profileView.nameTextField.text = customUser.userName
        profileView.phoneLabel.text = "+7 \(customUser.phone)"
    }
    
    func addTargets() {
        profileView.quitButton.addTarget(self,
                                         action: #selector(quit),
                                         for: .touchUpInside)
        
        profileView.changeAddressButton.addTarget(self, action: #selector(changeAddress), for: .touchUpInside)
        profileView.changePhone.addTarget(self, action: #selector(changePhone), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(avatarTap))
        
        profileView.avatar.addGestureRecognizer(tap)
        
    }
    
    @objc func avatarTap() {
        
        let actionSheet = UIAlertController(title: "Откуда взять картинку?",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Камера",
                                         style: .default) { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let galleryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
      
    
    @objc func quit() {
        
        AuthService.shared.signOut()
        let vc = SignInController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func changePhone() {
        let alert = UIAlertController(title: "Введите новый телефон", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        
        let okAction = UIAlertAction(title: "Готово!", style: .default) { _ in
            let newPhone = alert.textFields![0].text!

            FirestoreService.shared.saveProfile(id: self.customUser.id,
                                                phone: newPhone,
                                                name: self.customUser.userName,
                                                imageUrl: self.customUser.imageUrl,
                                                address: self.customUser.address) { result in
                switch result {
                case .success(let user):
                    self.profileView.phoneLabel.text = "+7 \(user.phone)"
                    self.getProfile()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    @objc func changeAddress() {
        
        let alert = UIAlertController(title: "Введите новый адрес", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.text = self.profileView.addressLabel.text
        }
        
        let okAction = UIAlertAction(title: "Готово!", style: .default) { _ in
            let newAddress = alert.textFields![0].text!

            FirestoreService.shared.saveProfile(id: self.customUser.id,
                                                phone: String(self.customUser.phone),
                                                name: self.customUser.userName,
                                                imageUrl: self.customUser.imageUrl,
                                                address: newAddress) { result in
                switch result {
                case .success(let user):
                    self.profileView.addressLabel.text = user.address
                    self.getProfile()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
    
}


