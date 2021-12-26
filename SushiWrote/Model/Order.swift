//
//  File.swift
//  SushiWrote
//
//  Created by Влад Мади on 19.12.2021.
//

import Foundation
import FirebaseFirestore

struct Order: Hashable, Decodable {
    
    var id = UUID().uuidString
    var positions = [Position]()
    var date = Date()
    var clientId: String
    var status: String = OrderStatus.new.rawValue
    var cost: Int { get {
        var summa = 0
        for position in positions {
            summa += position.price * position.count
        }
        return summa
    } set { }
        
    }
    
    var price: Int = 0
    
    
    
    init(positions: [Position], clientId: String) {
        self.positions = positions
        self.clientId = clientId
    }
    
    init?(doc: QueryDocumentSnapshot) {
        
        let data = doc.data()
        
        guard let id = data["id"] as? String  else { return nil }
        guard let clientId = data["clientId"] as? String else { return nil }
        guard let date = data["date"] as? Timestamp else { return nil }
        guard let status = data["status"] as? String else { return nil }
        guard let price = data["cost"] as? Int else { return nil }
        
        self.id = id
        self.clientId = clientId
        self.price = price
        self.date = date.dateValue()
        self.status = status
        
        
    }
    
    
    
    
    
}
