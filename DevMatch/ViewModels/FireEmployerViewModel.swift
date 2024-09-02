//
//  FireEmployerViewModel.swift
//  DevMatch
//
//  Created by Florian Lankes on 19.08.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FireEmployerViewModel: ObservableObject {
    
    @Published var employerProfilItem: [FireEmployerProfile] = []
    
    // Referenz auf Firebase-Authentifizierung und Firestore-Datenbank.
    private let firebaseAuthentication = Auth.auth()
    private let firebaseFirestore = Firestore.firestore()
    // Listener, um Echtzeit-Updates von der Firestore-Datenbank zu erhalten.
    private var listener: ListenerRegistration?
    
    //MARK: - Funktion zum Abrufen der Arbeitgeberprofile des aktuellen Benutzers.
    func createNewEmployerProfil(companyName: String, contactEmail: String, job: String, city: String, userId: String, massage: String) {
        guard let userId = self.firebaseAuthentication.currentUser?.uid else {
            print("User is not signed in")
            return
        }
        // Neues Arbeitgeberprofil erstellen mit den übergebenen Parametern.
        let newFireEmployerProfil = FireEmployerProfile(companyName: companyName, contactEmail: contactEmail, job: job, city:city, massage: massage, userId: userId)
        // Versuch, das neue Profil in der Firestore-Datenbank zu speichern.
        do {
            try self.firebaseFirestore.collection("ArbeitnehmerProfile").addDocument(from: newFireEmployerProfil)
        } catch {
            print(error)
        }
    }
    
    //MARK: - Funktion zum Abrufen der Arbeitgeberprofile des aktuellen Benutzers.
    func fetchEmployerProfilItem() {
        guard let userId = self.firebaseAuthentication.currentUser?.uid else {
            print("User is not signed in")
            return
        }
        // Echtzeit-Listener für die Sammlung "ArbeitgeberProfile", der alle Profiländerungen für den aktuellen Benutzer überwacht.
        self.listener = self.firebaseFirestore.collection("ArbeitgeberProfile")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { snapshot, error in
                if let error {
                    print("Fehler beim Laden der Profile: \(error)")
                    return
                }
                // Überprüfen, ob ein gültiger Snapshot zurückgegeben wurde.
                guard let snapshot else {
                    print("Snapshot ist leer")
                    return
                }
                // Die Profil-Daten aus den Dokumenten konvertieren.
                let employerProfilItem = snapshot.documents.compactMap { document -> FireEmployerProfile? in
                    do {
                        return try document.data(as: FireEmployerProfile.self)
                    } catch {
                        print(error)
                    }
                    return nil
                }
                self.employerProfilItem = employerProfilItem
            }
    }
    
    // MARK: - zum senden der Nachricht an Bewerber
    func sendContactInformationToApplicant(userId: String, contactInfo: FireEmployerProfile) {
        // Versuch, die Kontaktinformationen in das Bewerberprofil zu speichern.
        do {
            try firebaseFirestore.collection("ArbeitnehmerProfile")
                .document(userId)
                .collection("ArbeitgeberProfile")
                .addDocument(from: contactInfo) { error in
                    if let error = error {
                        print("Fehler beim Senden der Kontaktinformationen: \(error.localizedDescription)")
                    } else {
                        print("Kontaktinformationen erfolgreich gesendet.")
                    }
                }
        } catch {
            print("Fehler beim Konvertieren der Daten: \(error.localizedDescription)")
        }
    }
    
}
