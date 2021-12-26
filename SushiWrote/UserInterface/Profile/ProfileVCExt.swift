//
//  ProfileVCExt.swift
//  SushiWrote
//
//  Created by Влад Мади on 26.12.2021.
//

import UIKit

extension ProfileController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        let imageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        StorageService.shared.uploadPhoto(photo: imageFromPicker) { result in
            switch result {
            case .success(let url):
                
                FirestoreService.shared.saveProfile(id: self.customUser.id,
                                                    phone: String(self.customUser.phone),
                                                    name: self.customUser.userName,
                                                    imageUrl: url.absoluteString,
                                                    address: self.customUser.address) { result in
                    switch result {
                        
                    case .success(let user):
                        self.customUser = user
                        self.profileView.avatar.image = imageFromPicker
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ProfileController: ProfileDelegate {
    func updateViews() {
        getOrders()
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderProfileCell.reuseId, for: indexPath) as! OrderProfileCell
        
        let order = orders[indexPath.row]
        
        cell.mainLabel.text = "\(order.date)"
        cell.detailLabel.text = order.status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    
}

extension ProfileController: UITextFieldDelegate {
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        FirestoreService.shared.saveProfile(id: self.customUser.id,
                                            phone: String(self.customUser.phone),
                                            name: textField.text,
                                            imageUrl: self.customUser.imageUrl,
                                            address: self.customUser.address) { result in
            switch result {
            case .success(let user):
                self.profileView.nameTextField.text = user.address
                self.getProfile()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

