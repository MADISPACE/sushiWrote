//
//  CartController.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import UIKit

protocol CartDelegate {
    func addToCart(position: Position)
}

class CartController: UIViewController {

    let cartView = CartView()
    var positions = [Position]()
    var delegate: ProfileDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = cartView
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        updateViews()
        addTargets()
    }
    
    
    func addTargets() {
        cartView.clearButton.addTarget(self, action: #selector(clearCart), for: .touchUpInside)
        cartView.orderButton.addTarget(self, action: #selector(sendOrder), for: .touchUpInside)
    }
    
    @objc func clearCart() {
        
        positions.removeAll()
        updateViews()
    }
    
    @objc func sendOrder() {
        
        let order = Order(positions: self.positions,
                          clientId: AuthService.shared.currentUser!.uid)
        
        FirestoreService.shared.send(order: order) { result in
            switch result {
            case .success(let order):
                print("Ваш заказ от \(order.date) был принят")
                self.positions.removeAll()
                self.updateViews()
                self.delegate?.updateViews()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func updateViews() {
        var sum = 0
        
        for position in positions {
            sum += (position.price * position.count)
        }
        cartView.sumLabel.text = "\(sum) р."
        cartView.tableView.reloadData()
    }


}

extension CartController: CartDelegate {
    
    func addToCart(position: Position) {
        self.positions.append(position)
        updateViews()
    }
}

extension CartController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PositionCell.reuseId) as! PositionCell
        
        let pos = positions[indexPath.row]
        
        cell.titleLabel.text = pos.title
        cell.countLabel.text = "\(pos.count) шт."
        cell.priceLabel.text = "\(pos.count * pos.price) р."
        
        return cell
    }
    
    
}
