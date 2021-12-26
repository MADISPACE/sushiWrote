//
//  FirestoreService.swift
//  SushiWrote
//
//  Created by Влад Мади on 19.12.2021.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private var goodsRef: CollectionReference {
        return db.collection("goods")
    }
    
    private var ordersRef: CollectionReference {
        return db.collection("orders")
    }
    
    private init() { }
    
    func getPositions(by orderId: String, completion: @escaping (Result<[Position], Error>) -> Void) {
        
        let positionsRef = ordersRef.document(orderId).collection("positions")
        
        positionsRef.getDocuments { qSnap, error in
            
            var positions = [Position]()
            
            for doc in qSnap!.documents {
                guard let position = Position(doc: doc) else {
                    completion(.failure(error!))
                    return
                }
                positions.append(position)
            }
            
            completion(.success(positions))
        }
        
    }
    
    func getOrders(by userId: String?, completion: @escaping (Result<[Order], Error>) -> ()) {
        
        ordersRef.getDocuments { qSnap, error in
            var orders = [Order]()
            for doc in qSnap!.documents {
                if userId != nil {
                    if let order = Order(doc: doc), order.clientId == AuthService.shared.currentUser!.uid {
                        orders.append(order)
                    }
                } else {
                    guard let order = Order(doc: doc) else {
                        return
                    }
                    orders.append(order)
                }
                completion(.success(orders))
            }
        }
    }
    
    
    
    func send(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        
        let orderRef = ordersRef.document(order.id)
        let positionsRef: CollectionReference = orderRef.collection("positions")
        
        orderRef.setData(["id" : order.id,
                          "date" : order.date,
                          "clientId" : order.clientId,
                          "status" : order.status,
                          "cost": order.cost]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                
                for position in order.positions {
                    positionsRef.document(position.id).setData(["id" : position.id,
                                                                "title" : position.title,
                                                                "price": position.price,
                                                                "count" : position.count]) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(order))
                        }
                    }
                }
            }
        }
    }
    
    func getGoods(completion: @escaping(Result<[Goods], Error>) -> Void) {
        
        goodsRef.getDocuments { querySnap, error in
            if let qSnap = querySnap {
                var goods = [Goods]()
                for doc in qSnap.documents {
                    if let good = Goods(doc: doc) {
                        goods.append(good)
                    }
                }
                completion(.success(goods))
            }
        }
    }
    
    func saveGoods(goods: Goods, completion: @escaping(Result<Goods, Error>) -> Void) {
        
        goodsRef.document(goods.id).setData(["id": goods.id,
                                             "title": goods.title,
                                             "price": goods.price,
                                             "description": goods.description,
                                             "category": goods.category,
                                             "imageTitle": goods.imageTitle
                                            ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(goods))
            }
        }
    }
    
    //MARK: Save Profile
    func saveProfile(id: String,
                     phone: String?,
                     name: String?,
                     imageUrl: String?,
                     address: String?, completion: @escaping(Result<CustomUser, Error>) -> Void) {
        
        let phone = Int(phone ?? "0")
        
        let customUser = CustomUser(userName: name ?? "",
                                    imageUrl: imageUrl ?? "NotFound",
                                    id: id,
                                    phone: phone ?? 0,
                                    address: address ?? "")
        
        self.usersRef.document(id).setData(customUser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(customUser))
            }
        }
    }
    
    func getProfile(id: String,
                    completion: @escaping (Result<CustomUser, Error>) -> Void) {
        
        let docRef = usersRef.document(id)
        
        docRef.getDocument { snap, error in
            
            if let snap = snap, snap.exists {
                guard let customUser = CustomUser(doc: snap) else {
                    completion(.failure(error!))
                    return
                }
                
                completion(.success(customUser))
                
            } else {
                completion(.failure(error!))
            }
        }
    }
}

