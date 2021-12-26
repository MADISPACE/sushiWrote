//
//  TabBarController.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    var userId: String
    
    init(userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var customUser: CustomUser = CustomUser(userName: "",
                                                imageUrl: "",
                                                id: "",
                                                phone: 0,
                                                address: "")
        
        FirestoreService.shared.getProfile(id: self.userId) { result in
            switch result {
                
            case .success(let user):
                customUser = user
                
                
                let cartVC = CartController()
                let profileVC = ProfileController(customUser: customUser)
                cartVC.delegate = profileVC
                
                self.viewControllers = [
                    self.generateController(rootVC: MenuController(),
                                       title: "Меню",
                                       image: UIImage(systemName: "circles.hexagongrid.fill")!),
                    self.generateController(rootVC: cartVC,
                                       title: "Корзина",
                                       image: UIImage(systemName: "cart.fill")!),
                    self.generateController(rootVC: profileVC,
                                       title: "Профиль",
                                       image: UIImage(systemName: "person.crop.circle.fill")!)]
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
  
        tabBar.tintColor = ColorsLibrary.darkGreen
        tabBar.backgroundColor = ColorsLibrary.lightGreen
        
    }
    
    func generateController(rootVC: UIViewController,
                            title: String,
                            image: UIImage) -> UIViewController {
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.tabBarItem.image = image
        navVC.tabBarItem.title = title
        
        return navVC
    }
}


