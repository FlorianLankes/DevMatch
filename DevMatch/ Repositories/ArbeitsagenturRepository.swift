//
//  ArbeitsagenturRepository.swift
//  DevMatch
//
//  Created by Florian Lankes on 04.07.24.
//

import Foundation

class ArbeitsagenturRepository {
    
    //MARK: - Diese Methode ruft eine Liste von Jobs ab, die dem Suchbegriff "App-Entwickler" entsprechen und sich in Deutschland befinden.
    func fetchJobs() async throws -> [ArbeitsagenturSearchResult.Stellenangebot] {
        // URL der API, die Jobangebote abruft.
        guard let url  = URL(string: "https://rest.arbeitsagentur.de/jobboerse/jobsuche-service/pc/v4/app/jobs?was=App-Entwickler&wo=Deutschland&page=1&size=50&umkreis=25") else {
            throw ApiError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        // Hinzufügen des API-Schlüssels zu den HTTP-Headern für die Authentifizierung.
        urlRequest.setValue(ApiKeys.apiKeyArbeitagentur, forHTTPHeaderField: "X-API-Key")
        
        // Asynchrone Anfrage an die API senden und die Antwort in `data` und `_` (Statuscode) aufteilen.
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        // Decodieren der erhaltenen JSON-Daten in ein `ArbeitsagenturSearchResult`-Objekt.
        let searchResult = try JSONDecoder().decode(ArbeitsagenturSearchResult.self, from: data)
        return searchResult.stellenangebote
    }
    
    //MARK: - Diese Methode sucht nach Jobs basierend auf dem angegebenen Suchbegriff und gibt das Suchergebnis zurück.
    func searchJob(search: String) async throws -> ArbeitsagenturSearchResult {
        // URL der API, die Jobangebote basierend auf dem Suchbegriff abruft.
        guard let url = URL(string: "https://rest.arbeitsagentur.de/jobboerse/jobsuche-service/pc/v4/app/jobs?was=App-Developer&wo=\(search)&page=1&size=50&umkreis=25") else {
            throw ApiError.invalidURL
        }
        // Hinzufügen des API-Schlüssels zu den HTTP-Headern für die Authentifizierung.
        var urlRequest = URLRequest(url: url)
        // Asynchrone Anfrage an die API senden und die Antwort in `data` und `_` (Statuscode) aufteilen.
        urlRequest.setValue(ApiKeys.apiKeyArbeitagentur, forHTTPHeaderField: "X-API-Key")
        
        // Asynchrone Anfrage an die API senden und die Antwort in `data` und `_` (Statuscode) aufteilen.
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode(ArbeitsagenturSearchResult.self, from: data)
    }
}




