//
//  ArbeitsagenturSearchResult.swift
//  DevMatch
//
//  Created by Florian Lankes on 04.07.24.
//

import Foundation

struct ArbeitsagenturSearchResult: Codable {
    
    let stellenangebote: [Stellenangebot]
    
    struct Stellenangebot: Codable, Identifiable {
        let beruf: String
        let titel: String?
        let refnr: String
        let arbeitsort: Arbeitsort?
        let arbeitgeber: String
        let aktuelleVeroeffentlichungsdatum: String?
        let modifikationsTimestamp: String
        let eintrittsdatum: String
        let kundennummerHash: String?
        let externeUrl: String?
        //MARK: - Identifiable
        var id: String {refnr}
    }
    struct Arbeitsort: Codable {
        let plz: String?
        let ort: String?
        let region: String?
        let land: String
        let koordinaten: Koordinaten?
    }
    struct Koordinaten: Codable {
        let lat: Double?
        let lon: Double?
    }
    
}




