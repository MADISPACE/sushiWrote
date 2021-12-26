//
//  DetailController.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import UIKit

class DetailController: UIViewController {
    
    var delegate: CartDelegate?
    
    let detailView = DetailView()
    var goods = Goods(id: "",
                      title: "",
                      price: 0,
                      description: "",
                      imageTitle: "",
                      category: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = detailView
        configViews()
        addTargets()
        downloadPic()
        
    }
    
    func downloadPic() {
        StorageService.shared.downloadGoodsPic(title: goods.imageTitle) { result in
            switch result {
                
            case .success(let data):
                
                guard let image = UIImage(data: data) else {
                    return
                }
                self.detailView.imageView.image = image
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addTargets() {
        detailView.addToCartButton.addTarget(self, action: #selector(showAddToCartAlert), for: .touchUpInside)
    }
    
    @objc func showAddToCartAlert() {
        
        let alert = UIAlertController(title: "Введите количество:",
                                      message: nil,
                                      preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Количество"
            textField.keyboardType = .numberPad
        }
        
        let addToCartButton = UIAlertAction(title: "Добавить",
                                            style: .default) { _ in
            
            guard let countText = alert.textFields![0].text else {
                return
            }
            
            guard let count = Int(countText) else {
                return
            }
            
            let position = Position(title: self.goods.title,
                                    price: self.goods.price,
                                    count: count)
            
            self.delegate?.addToCart(position: position)
            
        }
        
        let cancelAction = UIAlertAction(title: "отмена", style: .destructive, handler: nil)
        
        alert.addAction(addToCartButton)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func configViews() {
        
        detailView.titleLabel.text = goods.title
        detailView.priceLabel.text = "\(goods.price) р."
        detailView.descrTextView.text = goods.description
        detailView.imageView.image = UIImage(named: goods.imageTitle)
    }

}
