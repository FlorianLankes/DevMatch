//
//  NewsViewModel.swift
//  DevMatch
//
//  Created by Florian Lankes on 25.07.24.
//

import Foundation

class NewsViewModel: ObservableObject {
    
    @Published var articels: [Articel] = []
    private var repository = NewsRepository()
    
    //MARK: - Funktion, die Tech und IT Nachrichten lädt und die Artikelliste aktualisiert.
    @MainActor
    func loadeTechNews() {
        Task {
            do {
                let result: NewsResult = try await repository.fetchArticels()
                self.articels = result.articles
            } catch {
                print(error)
            }
        }
    }
}
