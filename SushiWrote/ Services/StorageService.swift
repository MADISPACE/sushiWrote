//
//  StorageService.swift
//  SushiWrote
//
//  Created by Влад Мади on 26.12.2021.
//

import FirebaseStorage
import UIKit

class StorageService {
    
    static let shared = StorageService()
    
    let storageRef = Storage.storage().reference()
    
    private var avatarsRef: StorageReference {
        return storageRef.child("avatars")
    }
    
    func downloadGoodsPic(title: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let fileRef = storageRef.child("goods/\(title)")
        
        fileRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }

            completion(.success(data))
        }
        
    }
    
    func downloadPhoto(url: String,
                       completion: @escaping (Result<Data, Error>) -> Void) {
        
        let fileRef = storageRef.child("avatars/\(AuthService.shared.currentUser!.uid)")
        
        fileRef.getData(maxSize: 3 * 1024 * 1024) { data, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(data))
        }
    }
    
    func uploadGoodsPic(goodsId: String,
        photo: UIImage,
                        completion: @escaping (Result<URL, Error>) -> Void) {
        
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let goodsRef = storageRef.child("goods")
        goodsRef.child(goodsId).putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            
            goodsRef.child(goodsId).downloadURL { url, error in
                if let url = url {
                    completion(.success(url))
                } else if error != nil {
                    completion(.failure(error!))
                }
            }
            
        }
        
    }
    
    func uploadPhoto(photo: UIImage,
                     completion: @escaping (Result<URL, Error>) -> Void) {
        
        guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        avatarsRef.child(AuthService.shared.currentUser!.uid).putData(imageData, metadata: metadata) { metadata, error in
            
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            
            self.avatarsRef.child(AuthService.shared.currentUser!.uid).downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                
                completion(.success(url))
            }
        }
    }

}




