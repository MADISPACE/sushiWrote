//
//  MainAdminController.swift
//  SushiWrote
//
//  Created by Влад Мади on 19.12.2021.
//

import UIKit

class MainAdminController: UIViewController {
    
    let mainAdminView = MainAdminView()
    var orders = [Order]() {
        didSet {
            mainAdminView.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = mainAdminView
        mainAdminView.tableView.dataSource = self
        mainAdminView.tableView.delegate = self
        getOrders()
        
        mainAdminView.newGoodsButton.addTarget(self, action: #selector(addNewTap), for: .touchUpInside)
        mainAdminView.quitButton.addTarget(self, action: #selector(quit), for: .touchUpInside)
    }
    
    @objc func quit() {
        AuthService.shared.signOut()
        let vc = SignInController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func addNewTap() {
        let vc = AddGoodsController()
        self.present(vc, animated: true, completion: nil)
    }
    
    func getOrders() {
        FirestoreService.shared.getOrders(by: nil) { result in
            
            switch result {
            case .success(let orders):
                self.orders = orders
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

}


extension MainAdminController: UITableViewDelegate,
                               UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailAdminController(order: self.orders[indexPath.row])
        
        self.present(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderAdminCell.reuseId,
                                                 for: indexPath) as! OrderAdminCell
        let order = orders[indexPath.row]
        
        
        
        cell.dateLabel.text = Helper.dateToStr(date: order.date)
        cell.priceLabel.text = "\(order.price) р."
        cell.statusLabel.text = order.status
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
    
}
