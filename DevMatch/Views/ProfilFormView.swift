//
//  ProfilFormView.swift
//  DevMatch
//
//  Created by Florian Lankes on 08.07.24.
//

import SwiftUI

struct ProfilFormView: View {
    
    @EnvironmentObject private var loginViewModle: LoginViewModel
    
    @ObservedObject private var employerProfielViewModel = FireEmployerViewModel()
    @ObservedObject private var arbeitnehmerProfielViewModel = FireApplicantProfilViewModel()
    
    @State private var aliasname: String = ""
    @State private var city: String = ""
    @State private var jobTitle: String = ""
    @State private var education: String = ""
    @State private var description: String = ""
    @State private var radius: Double = 100.0
    @State private var teamSpirit: Bool = false
    @State private var keepCalm: Bool = false
    @State private var feedback: Bool = false
    @State private var flexibility: Bool = false
    @State private var improveSkills: Bool = false
    @State private var isCanged: Bool = false
    
    @State private var showInfoSheet: Bool = false
    @State private var showSettings = false
    @State private var showMail = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .padding(.top, 20)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Personen Beschreibung")
                                .font(.headline)
                                .padding(.bottom, 5)
                                .monospaced()
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.yellow .opacity(0.8))
                                TextField("Aliasname:", text: $aliasname)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .monospaced()
                            }
                            HStack {
                                Image(systemName: "house.fill")
                                    .foregroundColor(.yellow .opacity(0.8))
                                TextField("Wo kommst du her?", text: $city)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .monospaced()
                            }
                            VStack {
                                Text("Weg bis zur arbeit? \(Int(radius)) km")
                                    .monospaced()
                                Slider(value: $radius, in: 0...200, step: 5)
                                
                            }
                            HStack {
                                Image(systemName: "list.bullet.clipboard.fill")
                                    .foregroundColor(.yellow .opacity(0.8))
                                TextField("Jobtitel", text: $jobTitle)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .monospaced()
                            }
                            HStack {
                                Image(systemName: "graduationcap.fill")
                                    .foregroundColor(.yellow .opacity(0.8))
                                TextField("Was hast Du davor gemacht?", text: $education)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .monospaced()
                            }
                            HStack {
                                Image(systemName: "person.fill.questionmark")
                                    .foregroundColor(.yellow .opacity(0.8))
                                TextField("Erzähl von Dir", text: $description)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .monospaced()
                            }
                            Spacer()
                            Divider()
                            HStack {
                                Text("Was passt zu Dir?")
                                    .font(.headline)
                                    .bold()
                                    .monospaced()
                                Spacer()
                                Text("Nein")
                                    .font(.subheadline)
                                    .foregroundColor(.yellow)
                                    .bold()
                                    .monospaced()
                                Text("/")
                                    .bold()
                                    .monospaced()
                                Text("Ja")
                                    .font(.subheadline)
                                    .padding(.trailing, 2)
                                    .foregroundColor(.cyan)
                                    .bold()
                                    .monospaced()
                            }
                            Divider()
                            Toggle("Arbeitest du gerne im Team", isOn: $teamSpirit)
                                .toggleStyle(NewToggleColor())
                                .monospaced()
                            Divider()
                            Toggle("Behältst du in Stresssituationen die Ruhe?", isOn: $keepCalm)
                                .toggleStyle(NewToggleColor())
                                .monospaced()
                            Divider()
                            Toggle("Bist du offen für konstruktives Feedback?", isOn: $feedback)
                                .toggleStyle(NewToggleColor())
                                .monospaced()
                            Divider()
                            Toggle("Bist du flexibel und anpassungsfähig?", isOn: $flexibility)
                                .toggleStyle(NewToggleColor())
                                .monospaced()
                            Divider()
                            Toggle("Strebst du ständig danach, deine Fähigkeiten zu verbessern und zu erweitern?", isOn: $improveSkills)
                                .toggleStyle(NewToggleColor())
                                .monospaced()
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                    }
                    // Button, der das Profil speichert, indem die ViewModel-Funktion aufgerufen wird
                    Button(action: {
                        arbeitnehmerProfielViewModel.createNewApplicantProfil(aliasname: aliasname, jobTitle: jobTitle, city: city, education: education, description: description, radius: radius, teamSpirit: teamSpirit, keepCalm: keepCalm, feedback: feedback, flexibility: flexibility, improveSkills: improveSkills, isCanged: isCanged)
                    }) {
                        Text("Eingaben Veröffentlichen")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                            .monospaced()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.yellow .opacity(0.8))
                                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                            )
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("\(loginViewModle.user?.nickname ?? "?"), lass dich finden")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        employerProfielViewModel.fetchEmployerProfilItem()
                        showMail.toggle()
                    }) {
                        Label("Mail", systemImage: "envelope.fill")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showInfoSheet.toggle()
                    }) {
                        Label("Info", systemImage: "info.circle")
                    }
                    
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .sheet(isPresented: $showInfoSheet) {
            InfoView()
        }
        .sheet(isPresented: $showMail) {
            MailSheetView()
        }
        
    }
}

//MARK: -  Benutzerdefinierter Toggle-Stil
struct NewToggleColor: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color.cyan : Color.yellow .opacity(0.8))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfilFormView()
        .environmentObject(LoginViewModel())
}
