//
//  MerklistView.swift
//  DevMatch
//
//  Created by Florian Lankes on 10.07.24.
//

import SwiftUI

struct MerklistView: View {
    @StateObject private var merklistViewModel = MerklistViewModel()
    
    @EnvironmentObject private var arbeitsagenturViewModel: ArbeitsagenturViewModel
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if merklistViewModel.merklistItem.isEmpty {
                    Image("logo")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text("\(loginViewModel.user?.nickname ?? "Hey"), deine Liste ist noch leer!")
                        .monospaced()
                        .foregroundColor(.cyan)
                } else {
                    List(merklistViewModel.merklistItem) { item in
                        if let job = arbeitsagenturViewModel.jobs.first(where: { $0.id == item.jobId}) {
                            NavigationLink(destination: JobDetailView(job: job)) {
                                VStack(alignment: .leading) {
                                    Spacer(minLength: 2)
                                    Text(item.arbeitgeber)
                                        .font(.headline)
                                        .monospaced()
                                        .bold()
                                        .overlay(
                                            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                                .mask(Text(item.arbeitgeber)
                                                    .font(.headline)
                                                    .monospaced()
                                                    .bold()
                                                )
                                        )
                                    Spacer(minLength: 5)
                                    HStack {
                                        Button(action: {
                                            merklistViewModel.deleteMerklistItem(with: item.id)
                                        }) {
                                            Image(systemName: "heart.fill")
                                        }
                                        VStack(alignment: .leading) {
                                            Text(item.titel)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            Text(item.ort ?? "Keine Angabe")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Spacer()
                                }
                                .swipeActions {
                                    Button("löschen", role: .destructive) {
                                        merklistViewModel.deleteMerklistItem(with: item.id)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                merklistViewModel.fetchMerklistItems()
            }
            .navigationTitle("\(loginViewModel.user?.nickname ?? "User")s Merkliste")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Label("Einstellungen", systemImage: "gear")
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

#Preview {
    MerklistView()
        .environmentObject(LoginViewModel())
        .environmentObject(ArbeitsagenturViewModel())
}

