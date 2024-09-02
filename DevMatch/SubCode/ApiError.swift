//
//  AP.swift
//  DevMatch
//
//  Created by Florian Lankes on 04.07.24.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case decodingError(Error)
}
