//
//  ArbeitsargenturView.swift
//  DevMatch
//
//  Created by Florian Lankes on 04.07.24.
//

import SwiftUI

struct ArbeitsargenturView: View {
    @EnvironmentObject private var arbeitsagenturViewModel : ArbeitsagenturViewModel
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    @State private var searchText: String = ""
    @State private var showSettings = false
    @State private var showProfil = false
    
    var body: some View {
        NavigationStack {
            List(arbeitsagenturViewModel.jobs) { job in
                NavigationLink(destination: JobDetailView(job: job)) {
                    HStack(alignment: .top, spacing: 15) {
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        VStack(alignment: .leading, spacing: 8) {
                            Text(job.beruf)
                                .font(.headline)
                                .monospaced()
                                .bold()
                                .overlay(
                                    LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .mask(Text(job.beruf)
                                            .font(.headline)
                                            .monospaced()
                                            .bold()
                                        )
                                )
                            Text(job.arbeitgeber)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            HStack {
                                Text(job.arbeitsort?.plz ?? "Keine Angabe")
                                Text(job.arbeitsort?.ort ?? "Keine Angabe")
                                Spacer()
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listRowBackground(Color.clear)
                .listRowSeparatorTint(Color.cyan)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Jobangebote")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "In welcher Stadt suchst du?")
            .onChange(of: searchText) { _, newCity in
                arbeitsagenturViewModel.loadSearchJobs(search: newCity)
            }
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
    ArbeitsargenturView()
        .environmentObject(LoginViewModel())
        .environmentObject(ArbeitsagenturViewModel())
}

