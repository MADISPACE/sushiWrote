//
//  Goods.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import Foundation
import FirebaseFirestore

struct Goods {
    
    let id: String
    let title: String
    let price: Int
    let description: String
    let imageTitle: String
    var category: String = "Классические роллы"
    
    
    init?(doc: QueryDocumentSnapshot) {
        
        let data = doc.data()
        
        guard let id = data["id"] as? String  else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let imageTitle = data["imageTitle"] as? String  else { return nil }
        guard let category = data["category"] as? String  else { return nil }
        
        self.title = title
        self.id = id
        self.description = description
        self.price = price
        self.imageTitle = imageTitle
        self.category = category
        
        
    }
    
    init(id: String,
         title: String,
         price: Int,
         description: String,
         imageTitle: String,
         category: String) {
        
        self.id = id
        self.category = category
        self.imageTitle = imageTitle
        self.price = price
        self.title = title
        self.description = description
        
    }
    
    
    
    
    
}

