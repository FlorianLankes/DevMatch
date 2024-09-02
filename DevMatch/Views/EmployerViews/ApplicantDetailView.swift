//
//  ApplicantDetailView.swift
//  DevMatch
//
//  Created by Florian Lankes on 13.08.24.
//

import SwiftUI

struct ApplicantDetailView: View {
    
    @ObservedObject private var employerProfielViewModel = FireEmployerViewModel()
    
    @State private var navigateToCompanyInfo = false
    
    @State private var companyName: String = ""
    @State private var contactEmail: String = ""
    @State private var job: String = ""
    @State private var city: String = ""
    @State private var userId: String = ""
    @State private var id: String = ""
    @State private var massage: String = ""
    
    // Environment-Variable kann auf die aktuelle Präsentationsumgebung zugreifen, die es ermöglicht, die aktuelle Ansicht zu schließen und zur vorherigen Ansicht zurückzukehren.
    @Environment(\.presentationMode) var presentationMode
    let profil: FireApplicantProfil
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: CompanyinfomationView(profil: FireEmployerProfile(companyName: companyName, contactEmail: contactEmail, job: job, city: city, massage: massage, userId: userId), applicant: profil),
                                        isActive: $navigateToCompanyInfo
            ){
                EmptyView()
            }
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.blue.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    GroupBox(label:
                                HStack {
                        Image(systemName: "square.on.square.badge.person.crop.fill")
                            .foregroundColor(.blue)
                        Text("Bewerberinformationen")
                            .foregroundColor(.blue)
                            .monospaced()
                    }
                    ) {
                        VStack(alignment: .leading, spacing: 10) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Aliasname:")
                                    .font(.headline)
                                    .monospaced()
                                Text(profil.aliasname)
                                Divider()
                                Spacer()
                                Text("Beruf:")
                                    .font(.headline)
                                    .monospaced()
                                Text(profil.jobTitle)
                                Divider()
                                Spacer()
                                Text("Stadt:")
                                    .font(.headline)
                                    .monospaced()
                                Text(profil.city)
                                Divider()
                                Spacer()
                                Text("So weit würde ich fahren:")
                                    .font(.headline)
                                    .monospaced()
                                Text("\(profil.radius, specifier: "%.2f") km")
                                Divider()
                                Spacer()
                                Text("Das hab ich davor gemacht:")
                                    .font(.headline)
                                    .monospaced()
                                Text(profil.education)
                                Divider()
                                Spacer()
                                Text("Etwas über mich:")
                                    .font(.headline)
                                    .monospaced()
                                Text(profil.description)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    .groupBoxStyle(CustomGroupBoxStyle(color: .blue, opacity: 0.2))
                    GroupBox(label:
                                HStack{
                        Image(systemName: "person.crop.circle.badge.questionmark.fill")
                            .foregroundColor(.blue)
                        Text("Das haben wir \(profil.aliasname) gefragt:")
                            .foregroundColor(.blue)
                            .monospaced()
                    }
                    ){
                        VStack(alignment: .leading, spacing: 10) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Arbeitest du gerne im Team?")
                                    .font(.headline)
                                    .monospaced()
                                Text("Antwort: \(profil.teamSpirit ? "Ja" : "Nein")")
                                    .foregroundColor(profil.teamSpirit ? .yellow : .red)
                                Divider()
                                Spacer()
                                Text("Behältst du in Stresssituationen die Ruhe?")
                                    .font(.headline)
                                    .monospaced()
                                Text("Antwort: \(profil.keepCalm ? "Ja" : "Nein")")
                                    .foregroundColor(profil.keepCalm ? .yellow : .red)
                                Divider()
                                Spacer()
                                Text("Bist du offen für konstruktives Feedback?")
                                    .font(.headline)
                                    .monospaced()
                                Text("Antwort: \(profil.feedback ? "Ja" : "Nein")")
                                    .foregroundColor(profil.feedback ? .yellow : .red)
                                Divider()
                                Spacer()
                                Text("Bist du flexibel und anpassungsfähig?")
                                    .font(.headline)
                                    .monospaced()
                                Text("Antwort: \(profil.flexibility ? "Ja" : "Nein")")
                                    .foregroundColor(profil.flexibility ? .yellow : .red)
                                Divider()
                                Spacer()
                                Text("Strebst du ständig danach, deine Fähigkeiten zu verbessern und zu erweitern?")
                                    .font(.headline)
                                    .monospaced()
                                Text("Antwort: \(profil.improveSkills ? "Ja" : "Nein")")
                                    .foregroundColor(profil.improveSkills ? .yellow : .red)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    .groupBoxStyle(CustomGroupBoxStyle(color: .blue, opacity: 0.2))
                }
                VStack {
                    Spacer()
                    HStack {
                        Button("Dislike", systemImage: "hand.thumbsdown") {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        Button("Like", systemImage: "hand.thumbsup") {
                        navigateToCompanyInfo = true
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Infos über \(profil.aliasname)")
        }
    }
}

#Preview {
    ApplicantDetailView(profil: FireApplicantProfil(userId: "1", aliasname: "Hans", jobTitle: "appdeveloper", city: "Rosenheim", education: "alles mögliche", description: "Bla", radius: 100.0, teamSpirit: true, keepCalm: false, feedback: true, flexibility: false, improveSkills: true, isCanged: false))
}
