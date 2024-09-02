//
//  LoginViewModel.swift
//  DevMatch
//
//  Created by Florian Lankes on 02.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class LoginViewModel: ObservableObject {
    
    // Der aktuell eingeloggte Benutzer. Wird durch andere Teile der App verwendet.
    @Published private(set) var user: FireUser?
    @Published private(set) var passwordError: String?
    
    var isUserLoggedIn: Bool {
        self.user != nil
    }
    
    // Instanzen der Firebase Authentifizierung und Firestore
    private let firebaseAuthentication = Auth.auth()
    private let firebaseFirestore = Firestore.firestore()
    
    // Initialisierer, der überprüft, ob ein Benutzer bereits eingeloggt ist und die Benutzerdaten lädt
    init() {
        if let currentUser = self.firebaseAuthentication.currentUser {
            self.fetchFirestoreUser(withId: currentUser.uid)
        }
    }
    
    //MARK: -  Funktion zum Einloggen eines Benutzers
    func login(email: String, password: String) {
        firebaseAuthentication.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error in login: \(error)")
                return
            }
            guard let authResult, let userEmail = authResult.user.email else {
                print("authResult or Email are empty!")
                return
            }
            print("Successfully signed in with user-Id \(authResult.user.uid) and email \(userEmail)")
            self.fetchFirestoreUser(withId: authResult.user.uid)
        }
    }
    
    //MARK: -  Funktion zum Regestrieren eines neuen Benutzers
    func register(email: String, nickname: String, password: String, passwordCheck: String, companyName: String , companyLocation: String) {
        guard password == passwordCheck else {
            self.passwordError = "Passwörter stimmen nicht überein!"
            return
        }
        firebaseAuthentication.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error in registration: \(error)")
                return
            }
            guard let authResult, let userEmail = authResult.user.email else {
                print("authResult or Email are empty!")
                return
            }
            print("Successfully registered with user-Id \(authResult.user.uid) and email \(userEmail)")
            self.createFirestoreUser(id: authResult.user.uid, email: email, nickname: nickname, companyName: companyName , companyLocation: companyLocation)
            self.fetchFirestoreUser(withId: authResult.user.uid)
        }
    }
    
    //MARK: -  Funktion zur Registrierung eines neuen Arbeitgebers
    func registerEmployer(email: String, companyName: String, companyLocation: String, password: String, passwordCheck: String) {
        guard password == passwordCheck else {
            self.passwordError = "Passwörter stimmen nicht überein!"
            return
        }
        firebaseAuthentication.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error in registration: \(error)")
                return
            }
            guard let authResult, let userEmail = authResult.user.email else {
                print("authResult or Email are empty!")
                return
            }
            print("Successfully registered employer with user-Id \(authResult.user.uid) and email \(userEmail)")
            self.createFirestoreEmployer(id: authResult.user.uid, email: email, companyName: companyName, companyLocation: companyLocation)
            self.fetchFirestoreUser(withId: authResult.user.uid)
        }
    }
    
    //MARK: -  Funktion zum Abmelden des Benutzers
    func logout() {
        do {
            try firebaseAuthentication.signOut()
            self.user = nil
        } catch {
            print("Error in logout: \(error)")
        }
    }
    
    //MARK: -  Private Funktion zum Erstellen eines Benutzerdokuments in Firestore
    private func createFirestoreUser(id: String, email: String, nickname: String, companyName: String, companyLocation: String) {
        let newFireUser = FireUser(email: email, nickname: nickname, regesteredAt: Date(),companyName: nil , companyEmail: nil, id: id)
        do {
            try self.firebaseFirestore.collection("users").document(id).setData(from: newFireUser)
        } catch {
            print("Error saving user in firestore: \(error)")
        }
    }
    
    //MARK: -  Private Funktion zum Erstellen eines Arbeitgeberdokuments in Firestore
    private func createFirestoreEmployer(id: String, email: String, companyName: String, companyLocation: String) {
        let newFireUser = FireUser(email: email, nickname: nil, regesteredAt: Date(), companyName: companyName, companyEmail: companyLocation, id: id)
        do {
            try self.firebaseFirestore.collection("users").document(id).setData(from: newFireUser)
        } catch {
            print("Error saving employer in firestore: \(error)")
        }
    }
    
    //MARK: - Private Funktion zum Abrufen der Benutzerdaten aus Firestore
    private func fetchFirestoreUser(withId id: String) {
        self.firebaseFirestore.collection("users").document(id).getDocument { document, error in
            if let error {
                print("Error fetching user: \(error)")
                return
            }
            guard let document else {
                print("Document does not exist")
                return
            }
            do {
                let user = try document.data(as: FireUser.self)
                self.user = user
            } catch {
                print("Could not decode user: \(error)")
            }
        }
    }
    
    //MARK: -  Funktion zum Löschen des Benutzers sowohl aus Firestore als auch aus Firebase Authentication
    func deleteFireUser(completion: @escaping (Error?) -> Void) {
        guard let currentUser = firebaseAuthentication.currentUser else {
            print("Kein User angemeldet")
            completion(nil)
            return
        }
        let userId = currentUser.uid
        firebaseFirestore.collection("users").document(userId).delete { error in
            if let error = error {
                print("Error deleting user document from Firestore: \(error)")
                completion(error)
                return
            }
            currentUser.delete { error in
                if let error = error {
                    print("Error deleting user from Firebase Authentication: \(error)")
                    completion(error)
                } else {
                    print("Successfully deleted user from Firebase Authentication and Firestore.")
                    self.user = nil
                    completion(nil)
                }
            }
        }
    }
    
}
