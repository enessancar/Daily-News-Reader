//
//  AuthViewModel.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 18.01.2024.
//

import FirebaseFirestore
import FirebaseAuth

final class AuthViewModel {
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, "Login success")
            }
        }
    }
    
    // MARK: - Register
    func register(userName: String, email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let user = result?.user else {
                    print("User not found")
                    return
                }
                let fireStore = Firestore.firestore()
                
                let userDictionaray = [
                    "userName" : userName
                ] as! [String : Any]
                
                fireStore.collection("UsersInfo")
                    .document(user.uid)
                    .setData(userDictionaray) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                        completion(true,"Registration successful")
                    }
            }
        }
    }
    
    // MARK: - ForgotPassword
    func resetPassword(email: String, completion: @escaping (Bool, String) -> Void) {
        guard !email.isEmpty else {
            completion(false, "E-mail required")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                completion(false, "Reset password error: \(error.localizedDescription)")
            } else {
                completion(true, "Reset password success")
            }
        }
    }
    
    // MARK: - Change Password
    func changePassword(password: String, completion: @escaping (Bool, String) -> Void) {
        guard !password.isEmpty else {
            completion(false, "Password required")
            return
        }
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            if let error {
                completion(false, "Passwprd update error: \(error.localizedDescription)")
            } else {
                completion(true, "Password update")
            }
        }
    }
}

