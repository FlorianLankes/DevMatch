//
//  MerrklistItem.swift
//  DevMatch
//
//  Created by Florian Lankes on 18.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct FireMerklistItem: Codable, Identifiable {
    let arbeitgeber: String
    let beruf: String
    let titel: String
    let plz: String?
    let ort: String?
    let userId: String
    let jobId: String
    //MARK: - Identifiable
    @DocumentID var id: String?
}

