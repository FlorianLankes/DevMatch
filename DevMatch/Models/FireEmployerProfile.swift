//
//  FireEmployerProfile.swift
//  DevMatch
//
//  Created by Florian Lankes on 19.08.24.
//

import Foundation
import FirebaseFirestoreSwift

struct FireEmployerProfile: Codable, Identifiable {
    let companyName: String
    let contactEmail: String
    let job: String
    let city: String
    let massage: String
    let userId: String
    
    //MARK: - Identifiable
    @DocumentID var id: String?
}
