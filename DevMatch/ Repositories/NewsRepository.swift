//
//  NewsRepository.swift
//  DevMatch
//
//  Created by Florian Lankes on 25.07.24.
//

import Foundation

class NewsRepository {
    
    //MARK: - Diese Methode ruft Nachrichtenartikel von den angegebenen Nachrichtenquellen ab.
    func fetchArticels() async throws -> NewsResult {
        // URL der API, die Nachrichtenartikel von den Domains "techcrunch.com" und "thenextweb.com" abruft.
        guard let url = URL(string: "https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com") else {
            throw ApiError.invalidURL
        }
        // Erstellen eines URLRequest-Objekts für die API-Anfrage.
        var urlRequest = URLRequest(url: url)
        // Hinzufügen des API-Schlüssels zu den HTTP-Headern für die Authentifizierung.
        urlRequest.setValue(ApiKeys.apiKeyNews, forHTTPHeaderField: "X-Api-Key") //
        
        // Asynchrone Anfrage an die API senden und die Antwort in `data` und `_` (Statuscode) aufteilen.
        let ( data, _ ) = try await URLSession.shared.data(for: urlRequest)
        // Decodieren der erhaltenen JSON-Daten in ein `NewsResult`-Objekt.
        return try JSONDecoder().decode(NewsResult.self, from: data)
    }
}
