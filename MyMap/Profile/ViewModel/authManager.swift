//
//  authManager.swift
//  MyMap
//
//  Created by stud on 12/01/2026.
//

import SwiftUI
#if canImport(FirebaseAuth)
import FirebaseAuth
#endif
internal import Combine

class AuthManager: ObservableObject {

    #if canImport(FirebaseAuth)
    @Published var userSession: FirebaseAuth.User?
    #else
    @Published var userSession: Any?
    #endif

    init() {
        #if canImport(FirebaseAuth)
        self.userSession = Auth.auth().currentUser
        #else
        self.userSession = nil
        #endif
    }

    func signIn(email: String, password: String) {
        #if canImport(FirebaseAuth)
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.userSession = result?.user
            }
        }
        #endif
    }

    func signOut() {
        #if canImport(FirebaseAuth)
        try? Auth.auth().signOut()
        self.userSession = nil
        #endif
    }
}
