//
//  MenuController.swift
//  SushiWrote
//
//  Created by  Admin on 30.10.2021.
//

import UIKit

class MenuController: UIViewController {

    let menuView = MenuView()
    var goods = [Goods]()
    
    var classical = [Goods]()
    var burned = [Goods]()
    var sets = [Goods]()
    var maki = [Goods]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = menuView
        menuView.collectionView.dataSource = self
        menuView.collectionView.delegate = self
        getGoods()
    }
    
    func getGoods() {
        
        FirestoreService.shared.getGoods { result in
            switch result {
            case .success(let goods):
                
                for good in goods {
                    switch good.category {
                    case "Классические роллы":
                        self.classical.append(good)
                    case "Запечённые роллы":
                        self.burned.append(good)
                    case "Маки":
                        self.maki.append(good)
                    case "Сеты":
                        self.sets.append(good)
                    default: break
                    }
                }
                self.menuView.collectionView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}


extension MenuController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Возвращает количество секций
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    //Возвращает количество ячеек в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0: return classical.count
        case 1: return burned.count
        case 2: return sets.count
        case 3: return maki.count
        default: return 0
        }
        
    }
    
    //Создаёт, заполняет и возвращает ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SushiCell.reuseId, for: indexPath) as! SushiCell
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 4
        
        var rolls = [Goods]()
        
        switch indexPath.section {
        case 0: rolls = classical
        case 1: rolls = burned
        case 2: rolls = maki
        default: rolls = sets
        }
        
        let roll = rolls[indexPath.item]
        
        cell.titleLabel.text = roll.title
        cell.priceLabel.text = "\(roll.price) р."
        
        StorageService.shared.downloadGoodsPic(title: roll.imageTitle) { result in
            switch result {
                
            case .success(let data):
                cell.imageView.image = UIImage(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        return cell
    }
    
    //Отрабатывает по нажатию на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailController()
        
        switch indexPath.section {
        case 0: vc.goods = classical[indexPath.item]
        case 1: vc.goods = burned[indexPath.item]
        case 2: vc.goods = maki[indexPath.item]
        default: vc.goods = sets[indexPath.item]
        }
        
        vc.delegate = (tabBarController?.viewControllers![1] as! UINavigationController).visibleViewController as! CartController
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseId, for: indexPath) as! HeaderView
        
        var title: String? = ""
        
        switch indexPath.section {
        case 0: title = classical.count > 0 ? "Классические роллы" : nil
        case 1: title = burned.count > 0 ? "Запечённые роллы" : nil
        case 2: title = maki.count > 0 ? "Маки" : nil
        default: title = sets.count > 0 ? "Сеты" : nil
        }
        
        header.titleLabel.text = title
        
        return header
        
    }
    
}


