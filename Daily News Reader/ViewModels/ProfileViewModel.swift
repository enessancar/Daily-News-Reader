//
//  ProfileVM.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

final class ProfileViewModel {
    let currentUser = Auth.auth().currentUser?.uid
    
    func fetchUserName(completion: @escaping (String) -> Void) {
        if let currentUser {
            Firestore.firestore()
                .collection("UsersInfo")
                .document(currentUser)
                .getDocument { snapshot, error in
                    if let error {
                        print(error.localizedDescription)
                    }
                    if let snapshot = snapshot {
                        if let data = snapshot.data() {
                            let userName = data["userName"] as! String
                            completion(userName)
                        }
                    }
                }
        }
    }
    
    func uploadUserPhoto(imageData: UIImage) {
        
        if let currentUser {
            let storageRefernce = Storage.storage().reference()
            
            let imageData = imageData.jpegData(compressionQuality: 0.8)
            
            guard imageData != nil else{
                return
            }
            
            let fileRef = storageRefernce.child("Media/\(currentUser).jpg")
            fileRef.putData(imageData!, metadata: nil)
        }
    }
    
    func fetchUserPhoto(completion: @escaping (String) -> Void) {
        if let currentUser {
            let storageRef = Storage.storage().reference()
            
            let fileRef = storageRef.child("Media/\(currentUser).jpg")
            fileRef.downloadURL { url, error in
                if error == nil {
                    let imageUrl = url?.absoluteString
                    completion(imageUrl!)
                }
            }
        }
    }
}

