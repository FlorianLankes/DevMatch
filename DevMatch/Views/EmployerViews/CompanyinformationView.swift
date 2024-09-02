//
//  Companyinfomation.swift
//  DevMatch
//
//  Created by Florian Lankes on 19.08.24.
//

import SwiftUI

struct CompanyinfomationView: View {
    
    @ObservedObject private var employerProfielViewModel = FireEmployerViewModel()
    @ObservedObject private var applicantrofielViewModel = FireApplicantProfilViewModel()
    
    let profil: FireEmployerProfile
    let applicant: FireApplicantProfil
    
    @State private var shouldNavigate = false
    @State private var companyName: String = ""
    @State private var contactEmail: String = ""
    @State private var job: String = ""
    @State private var city: String = ""
    @State private var userId: String = ""
    @State private var massage: String = ""
    
    init(profil: FireEmployerProfile, applicant: FireApplicantProfil) {
        self.profil = profil
        self.applicant = applicant
        self._companyName = State(initialValue: profil.companyName)
        self._contactEmail = State(initialValue: profil.contactEmail)
        self._job = State(initialValue: profil.job)
        self._city = State(initialValue: profil.city)
        self._userId = State(initialValue: profil.userId)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.blue.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    TextField("Name der Firma:", text: $companyName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                        .monospaced()
                    
                    TextField("Emailadresse:", text: $contactEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                        .monospaced()
                    TextField("Was für ein Job?", text: $job)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                        .monospaced()
                    TextField("In welcher Stadt?", text: $city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                        .monospaced()
                    TextField("Nachricht an Bewwerber*in", text: $massage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                        .monospaced()
                    
                    Spacer()
                    NavigationLink(destination: ApplicantView(), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    Button(action: {
                       employerProfielViewModel.sendContactInformationToApplicant(userId: applicant.id!, contactInfo: FireEmployerProfile(companyName: companyName, contactEmail: contactEmail, job: job, city: city, massage: massage, userId: userId))
                    }) {
                        Text("Infos an Berwerber senden")
                            .font(.headline)
                            .monospaced()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .padding()
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding(.horizontal, 20)
            }
            .navigationTitle("Kontacktinformation")
        }
    }
}

//#Preview {
//    CompanyinfomationView(profil: FireEmployerProfile(companyName: "", contactEmail: "", job: "", city: "", massage: "", userId: ""), applicant: FireApplicantProfil)
//}
