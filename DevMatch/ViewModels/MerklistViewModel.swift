//
//  MerklistViewModel.swift
//  DevMatch
//
//  Created by Florian Lankes on 18.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MerklistViewModel: ObservableObject {
    @Published var merklistItem: [FireMerklistItem] = []
    
    // Referenz auf Firebase-Authentifizierung und Firestore-Datenbank.
    private let firebaseAuthentication = Auth.auth()
    private let firebaseFirestore = Firestore.firestore()
    // Listener für Echtzeit-Updates aus der Firestore-Datenbank.
    private var listener: ListenerRegistration?
    
    //MARK: - Funktion zum Erstellen eines neuen Merkliste-Eintrags und Speichern in Firestore.
    func createNewMerklistItem(title: String, arbeitgeber: String, beruf: String, plz: String?, ort: String,jobId: String) {
        // Überprüfen, ob der Benutzer eingeloggt ist. Ohne gültigen User kann kein Eintrag erstellt werden.
        guard let userId = self.firebaseAuthentication.currentUser?.uid else {
            print("User is not signed in")
            return
        }
        // Neues Merklistenelement mit den übergebenen Parametern erstellen.
        let newFireMerklistItem = FireMerklistItem(arbeitgeber: arbeitgeber, beruf: beruf, titel: title, plz: plz, ort: ort, userId: userId, jobId: jobId)
        // Versuch, den neuen Eintrag in der "merklist"-Sammlung der Firestore-Datenbank zu speichern.
        do {
            try self.firebaseFirestore.collection("merklist").addDocument(from: newFireMerklistItem)
        } catch {
            print(error)
        }
    }
    
    //MARK: - Funktion zum Abrufen aller Merkliste-Einträge des aktuellen Benutzers aus Firestore.
    func fetchMerklistItems() {
        guard let userId = self.firebaseAuthentication.currentUser?.uid else {
            print("User is not signed in")
            return
        }
        // Echtzeit-Listener für die Sammlung "merklist", der alle Einträge des aktuellen Benutzers überwacht.
        self.listener = self.firebaseFirestore.collection("merklist")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { snapshot, error in
                if let error {
                    print("Fehler beim Laden der Mekliste: \(error)")
                    return
                }
                // Überprüfen, ob ein gültiger Snapshot zurückgegeben wurde.
                guard let snapshot else {
                    print("Snapshot ist leer")
                    return
                }
                // Die Dokumente aus dem Snapshot konvertieren und die Merkliste aktualisieren.
                let merklistItems = snapshot.documents.compactMap { document -> FireMerklistItem? in
                    do {
                        return try document.data(as: FireMerklistItem.self)
                    } catch {
                        print(error)
                    }
                    return nil
                }
                // Die Merkliste in der UI mit den neuen Daten aktualisieren.
                self.merklistItem = merklistItems
            }
    }
    
    //MARK: - Funktion zum Löschen eines Merkliste-Eintrags aus Firestore.
    func deleteMerklistItem(with id: String?) {
        guard let id else {
            print("Item hat keine ID")
            return
        }
        firebaseFirestore.collection("merklist").document(id).delete() { error in
            if let error {
                print("Löschen fehlgeschlagen: \(error)")
            }
        }
    }
    
}
