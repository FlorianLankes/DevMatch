//
//  ArbeitsagenturViewModel.swift
//  DevMatch
//
//  Created by Florian Lankes on 04.07.24.
//

import Foundation
import UIKit

class ArbeitsagenturViewModel: ObservableObject {
    @Published var jobs: [ArbeitsagenturSearchResult.Stellenangebot] = []
    
    private let jobRepository = ArbeitsagenturRepository()
    
    // Initialisierungsfunktion, die sofort beim Erstellen des ViewModels startet
    // und die aktuellen Stellenangebote lädt.
    init() {
        Task {
            await self.loadJobs()
        }
    }
    
    //MARK: -  Funktion zum Laden von Stellenangeboten über das Repository.
    @MainActor
    func loadJobs() {
        Task {
            do {
                self.jobs = try await self.jobRepository.fetchJobs()
                
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: -  Funktion zum Suchen nach spezifischen Stellenangeboten basierend auf einem Suchbegriff.
    @MainActor
    func loadSearchJobs(search: String) {
        Task {
            do {
                let result: ArbeitsagenturSearchResult = try await jobRepository.searchJob(search: search)
                self.jobs = result.stellenangebote
                print (jobs)
            } catch {
                print(error)
            }
        }
    }
    
}
