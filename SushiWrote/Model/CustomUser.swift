//
//  CustomUser.swift
//  SushiWrote
//
//  Created by Влад Мади on 19.12.2021.
//

import Foundation
import FirebaseFirestore

struct CustomUser: Hashable, Decodable {
    
    var userName: String
    var imageUrl: String
    var id: String
    var phone: Int
    var address: String
    var orders = [Order]()
    
    var representation: [String: Any] {
        
        var repr: [String : Any] = ["userName": userName,
                                    "imageUrl": imageUrl,
                                    "id" : id,
                                    "phone" : phone,
                                    "address": address]
        return repr
    }
    
    init(userName: String,
         imageUrl: String,
         id: String,
         phone: Int,
         address: String) {
        
        self.imageUrl = imageUrl
        self.phone = phone
        self.userName = userName
        self.id = id
        self.address = address
        
    }
    
   
    
    init?(doc: DocumentSnapshot) {
        
        guard let data = doc.data() else { return nil }
        
        guard let userName = data["userName"] as? String else { return nil }
        guard let imageUrl = data["imageUrl"] as? String  else { return nil }
        guard let id = data["id"] as? String  else { return nil }
        guard let phone = data["phone"] as? Int  else { return nil }
        guard let address = data["address"] as? String  else { return nil }
        
        self.userName = userName
        self.id = id
        self.address = address
        self.phone = phone
        self.imageUrl = imageUrl
        
    }
    
}

