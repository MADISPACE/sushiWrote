//
//  Position.swift
//  SushiWrote
//
//  Created by  Admin on 06.11.2021.
//

import Foundation
import FirebaseFirestore

struct Position: Hashable, Decodable {
    
    var id = UUID().uuidString
    let title: String
    let price: Int
    var count: Int
    
    init(title: String, price: Int, count: Int) {
        self.title = title
        self.price = price
        self.count = count
    }
    
    
    init?(doc: QueryDocumentSnapshot) {
        
        let data = doc.data()
        
        guard let id = data["id"] as? String  else {
            print("1")
            return nil }
        guard let title = data["title"] as? String else {
            print("2")
            return nil }
        guard let price = data["price"] as? Int else {
            print("3")
            return nil }
        guard let count = data["count"] as? Int else {
            print("4")
            return nil }

        
        self.title = title
        self.id = id
        self.price = price
        self.count = count
        
    }
    
    
    
}
