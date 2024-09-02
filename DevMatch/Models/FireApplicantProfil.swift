//
//  FireArbeitnehmerProfil.swift
//  DevMatch
//
//  Created by Florian Lankes on 09.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct FireApplicantProfil: Codable, Identifiable {
    let userId: String
    let aliasname: String
    let jobTitle: String
    let city: String
    let education: String
    let description: String
    let radius: Double
    let teamSpirit: Bool
    let keepCalm: Bool
    let feedback: Bool
    let flexibility: Bool
    let improveSkills: Bool
    let isCanged: Bool
    //MARK: - Identifiable
    @DocumentID var id: String?
}
