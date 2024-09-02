//
//  FireUser.swift
//  DevMatch
//
//  Created by Florian Lankes on 02.07.24.
//

import Foundation

struct FireUser: Codable, Identifiable {
    let email: String
    let nickname: String?
    let regesteredAt: Date
    let companyName: String?
    let companyEmail: String?
    //MARK: - Identifiable
    let id: String
}
