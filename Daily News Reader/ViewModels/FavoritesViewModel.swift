//
//  FavoritesViewModel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class FavoritesViewModel {
    let currentUser = Auth.auth().currentUser?.uid
    
    func fetchFavorites(completion: @escaping([News]) -> ()) {
        if let currentUser {
            Firestore.firestore().collection("UsersInfo")
                .document(currentUser)
                .collection("favorites")
                .getDocuments { snaphot, error in
                    if let error {
                        print(error.localizedDescription)
                        return
                    }
                    guard let documents = snaphot?.documents else { return }
                    let news = documents.compactMap({try? $0.data(as: News.self)})
                    completion(news)
                }
        }
    }
    
    func removeFromFavorites(news: News) {
        if let currentUser {
            Firestore.firestore()
                .collection("UsersInfo")
                .document(currentUser)
                .collection("favorites")
                .document(news.url!.hash.description)
                .delete { error in
                    if let error {
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
