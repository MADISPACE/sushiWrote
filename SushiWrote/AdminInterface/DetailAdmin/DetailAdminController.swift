//
//  DetailAdminController.swift
//  SushiWrote
//
//  Created by Влад Мади on 26.12.2021.
//

import UIKit

class DetailAdminController: UIViewController {

    var order: Order
    
    var positions = [Position]() {
        didSet {
            self.detailAdminView.tableView.reloadData()
        }
    }
    
    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let detailAdminView = DetailAdminView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = detailAdminView
        detailAdminView.statusPicker.delegate = self
        detailAdminView.statusPicker.dataSource = self
        detailAdminView.tableView.delegate = self
        detailAdminView.tableView.dataSource = self
        getPositions()
        getProfile()
        
        detailAdminView.saveButton.addTarget(self, action: #selector(saveTap), for: .touchUpInside)
        
    }
    
    @objc func saveTap() {
        
        FirestoreService.shared.send(order: order) { result in
            switch result {
                
            case .success(let order):
                print(order.status)
                self.dismiss(animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    func getProfile() {
        FirestoreService.shared.getProfile(id: order.clientId) { result in
            switch result {
                
            case .success(let user):
                self.detailAdminView.nameLabel.text = user.userName
                self.detailAdminView.phoneLabel.text = "+7 \(user.phone)"
                self.detailAdminView.dateLabel.text = Helper.dateToStr(date: self.order.date)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPositions() {
        FirestoreService.shared.getPositions(by: order.id) { result in
            switch result {
                
            case .success(let positions):
                self.positions = positions
                self.order.positions = positions
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension DetailAdminController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: PositionCell.adminReuseId, for: indexPath) as! PositionCell
        
        let pos = positions[indexPath.row]
        
        cell.titleLabel.text = pos.title
        cell.priceLabel.text = "\(pos.price * pos.count) р."
        cell.countLabel.text = "\(pos.count) шт"
        
        return cell
        
    }
    
    
    
    
    
}

extension DetailAdminController : UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return OrderStatus.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return OrderStatus.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.order.status = OrderStatus.allCases[row].rawValue
        
    }
    
}
