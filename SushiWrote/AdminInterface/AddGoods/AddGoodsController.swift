//
//  AddGoodsController.swift
//  SushiWrote
//
//  Created by Влад Мади on 26.12.2021.
//

import UIKit

class AddGoodsController: UIViewController  {
    
    let categories = ["Классические роллы", "Запечённые роллы", "Маки", "Сеты"]
    
    var currentCategory = "Классические роллы"
    
    let addGoodsView = AddGoodsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = addGoodsView
        
        addGoodsView.picker.dataSource = self
        addGoodsView.picker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTap))
        addGoodsView.imageView.addGestureRecognizer(tap)
        addGoodsView.saveButton.addTarget(self, action: #selector(saveTap), for: .touchUpInside)
   
    }
    

    
    @objc func saveTap() {
        let goodsId = UUID().uuidString
        
        guard let title = self.addGoodsView.titleTF.text else { return }
        guard let desc = self.addGoodsView.descTF.text else { return }
        guard let price = Int(self.addGoodsView.priceTF.text!) else { return }
        
        StorageService.shared.uploadGoodsPic(goodsId: goodsId, photo: addGoodsView.imageView.image!) { result in
            switch result {
                
            case .success(_):
                
                let goods = Goods(id: goodsId,
                                  title: title,
                                  price: price,
                                  description: desc,
                                  imageTitle: goodsId,
                                  category: self.currentCategory)
                
                FirestoreService.shared.saveGoods(goods: goods) { result in
                    switch result {
                        
                    case .success(let goods):
                        print(goods.title)
                        self.dismiss(animated: true)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
    
    
}

extension AddGoodsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imageFromPicker = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        addGoodsView.imageView.image = imageFromPicker
        picker.dismiss(animated: true)
            
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}




extension AddGoodsController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentCategory = categories[row]
        print(currentCategory)
    }
    
}



