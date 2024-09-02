//
//  CompanyView.swift
//  DevMatch
//
//  Created by Florian Lankes on 13.08.24.
//

import SwiftUI

struct ApplicantView: View {
    
    @ObservedObject private var applicantProfielViewModel = FireApplicantProfilViewModel()
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    @State private var showInfoSheet: Bool = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            List(applicantProfielViewModel.applicantProfilItem) { profil in
                NavigationLink(destination: ApplicantDetailView(profil: profil)) {
                    VStack(alignment: .leading) {
                        Text(profil.aliasname)
                            .font(.headline)
                            .monospaced()
                            .bold()
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .mask(Text(profil.aliasname)
                                        .font(.headline)
                                        .monospaced()
                                        .bold()
                                    )
                            )
                        Text("Jobtietel: \(profil.jobTitle)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Wohnort: \(profil.city)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Breit zu fahren: Bis zu \(profil.radius, specifier: "%.2f") km")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Arbeitnehmer Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showInfoSheet.toggle()
                    }) {
                        Label("Info", systemImage: "info.circle")
                    }
                }
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
        .onAppear {
            applicantProfielViewModel.fetchApplicantProfilItemsForEmployer()
            
        }
        .sheet(isPresented: $showInfoSheet) {
            CompanyInfoView()
        }
    }
}

#Preview {
    ApplicantView()
}
