//
//  ArbeitnehmerProfilModel.swift
//  DevMatch
//
//  Created by Florian Lankes on 09.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FireApplicantProfilViewModel: ObservableObject {
    
    @Published var applicantProfilItem: [FireApplicantProfil] = []
    
    private let firebaseAuthentication = Auth.auth()
    private let firebaseFirestore = Firestore.firestore()
    private var listener: ListenerRegistration?
    
    //MARK: - Funktion zur Erstellung eines neuen Arbeitnehmerprofils und zum Speichern in Firestore.
    func createNewApplicantProfil(aliasname: String, jobTitle: String, city: String, education: String, description: String, radius: Double, teamSpirit: Bool, keepCalm: Bool, feedback: Bool, flexibility: Bool, improveSkills: Bool, isCanged: Bool){
        guard let userId = self.firebaseAuthentication.currentUser?.uid else {
            print("User is not signed in")
            return
        }
        // Neues Profil-Objekt mit den eingegebenen Daten erstellen.
        let newFireApplicantProfil = FireApplicantProfil(userId: userId, aliasname: aliasname, jobTitle: jobTitle, city: city, education: education, description: description, radius: radius, teamSpirit: teamSpirit, keepCalm: keepCalm, feedback: feedback, flexibility: flexibility, improveSkills: improveSkills, isCanged: isCanged)
        // Profil in Firestore-Datenbank speichern.
        do {
            try self.firebaseFirestore.collection("ArbeitnehmerProfile").addDocument(from: newFireApplicantProfil)
        } catch {
            print(error)
        }
    }
    
    //MARK: - Funktion zum Abrufen aller Arbeitnehmerprofile des angemeldeten Benutzers.
    func fetchApplicantProfilItems() {
        guard let userId = self.firebaseAuthentication.currentUser?.uid else {
            print("User is not signed in")
            return
        }
        // Echtzeit-Listener für die "ArbeitnehmerProfile"-Sammlung, der auf Änderungen wartet und diese aktualisiert.
        self.listener = self.firebaseFirestore.collection("ArbeitnehmerProfile")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { snapshot, error in
                if let error {
                    print("Fehler beim Laden der Profile: \(error)")
                    return
                }
                // Überprüfen, ob das Snapshot-Objekt gültig ist.
                guard let snapshot else {
                    print("Snapshot ist leer")
                    return
                }
                // Profil-Objekte aus den abgerufenen Dokumenten in der Firestore-Sammlung konvertieren.
                let applicantProfilItem = snapshot.documents.compactMap { document -> FireApplicantProfil? in
                    do {
                        return try document.data(as: FireApplicantProfil.self)
                    } catch {
                        print(error)
                    }
                    return nil
                }
                self.applicantProfilItem = applicantProfilItem
            }
    }
    
    //MARK:- Funktion zum laden der Arbeitnehmer Profile für Arbeitgeber
    func fetchEmployerContact() {
        guard let applicantId = applicantProfilItem.first?.id else {
            return
        }
        self.listener = self.firebaseFirestore.collection("ArbeitnehmerProfile").document(applicantId).collection("ArbeitgeberProfile")
            .addSnapshotListener { snapshot, error in
                if let error {
                    print("Fehler beim Laden der Profile: \(error)")
                    return
                }
                // Überprüfen, ob das Snapshot-Objekt gültig ist.
                guard let snapshot else {
                    print("Snapshot ist leer")
                    return
                }
                // Profil-Objekte aus den abgerufenen Dokumenten in der Firestore-Sammlung konvertieren.
                let applicantProfilItem = snapshot.documents.compactMap { document -> FireApplicantProfil? in
                    do {
                        return try document.data(as: FireApplicantProfil.self)
                    } catch {
                        print(error)
                    }
                    return nil
                }
                self.applicantProfilItem = applicantProfilItem
            }
    }
//    func fetchEmployerContact() {
//        guard let applicantId = applicantProfilItem.first?.id else {
//            return
//        }
//        self.listener = self.firebaseFirestore.collection("ArbeitnehmerProfile").document(applicantId).collection("ArbeitgeberProfile")
//            .addSnapshotListener { snapshot, error in
//                if let error = error {
//                    print("Fehler beim Laden der Profile: \(error)")
//                    return
//                }
//                guard let snapshot = snapshot else {
//                    print("Snapshot ist leer")
//                    return
//                }
//                // Profil-Objekte aus den abgerufenen Dokumenten in der Firestore-Sammlung konvertieren.
//                self.applicantProfilItem = snapshot.documents.compactMap { document -> FireApplicantProfil? in
//                    do {
//                        return try document.data(as: FireApplicantProfil.self)
//                    } catch {
//                        print("Fehler bei der Konvertierung: \(error)")
//                    }
//                    return nil
//                }
//            }
//    }
    
    //MARK: - Funktion zur Aktualisierung des Status eines Arbeitnehmerprofils.
    func updateApplicantProfil(with id: String?, isCanged: Bool) {
        guard let id else {
            print("Item hat keine Id")
            return
        }
        let fieldToUpdate = [
            "is Completed" : isCanged
        ]
        firebaseFirestore.collection("ArbeitnehmerProfile").document(id).updateData(fieldToUpdate) { error in
            if let error {
                print("Update fehlgeschlagen: \(error)")
            }
        }
    }
    
    //MARK:- Funktion zum laden der Arbeitnehmer Profile für Arbeitgeber
    func fetchApplicantProfilItemsForEmployer() {
        firebaseFirestore.collection("ArbeitnehmerProfile")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Fehler beim Abrufen der Daten: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("Keine Dokumente gefunden")
                    return
                }
                
                // Daten von den Dokumenten extrahieren
                self.applicantProfilItem = documents.compactMap { document -> FireApplicantProfil? in
                    // Versuch, das Dokument in ein `FireApplicantProfil`-Objekt zu dekodieren
                    do {
                        return try document.data(as: FireApplicantProfil.self)
                    } catch {
                        print("Fehler beim Dekodieren des Dokuments: \(error.localizedDescription)")
                        return nil
                    }
                }
            }
    }
}

