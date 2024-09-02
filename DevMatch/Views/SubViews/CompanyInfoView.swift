//
//  CompanyInfoView.swift
//  DevMatch
//
//  Created by Florian Lankes on 14.08.24.
//

import SwiftUI

struct CompanyInfoView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Arbeitgeber Info")
                        .font(.title)
                        .bold()
                        .monospaced()
                        .padding(.top, 40)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Image(systemName: "briefcase.fill")
                                    .foregroundColor(.green)
                                Text("Fairness im Auswahlprozess")
                                    .monospaced()
                                    .font(.headline)
                            }
                            Text("DEV-MATCH unterstützt Arbeitgeber dabei, einen fairen und transparenten Auswahlprozess zu gewährleisten. Achten Sie darauf, dass Sie alle Bewerber*innen gleich behandeln und Entscheidungen auf Basis von Qualifikationen und Fähigkeiten treffen.")
                                .monospaced()
                            
                            HStack {
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(.green)
                                Text("Chancengleichheit")
                                    .monospaced()
                                    .font(.headline)
                            }
                            Text("Chancengleichheit ist für uns von größter Bedeutung. Stellen Sie sicher, dass alle Bewerber*innen, unabhängig von Geschlecht, Herkunft oder anderen persönlichen Merkmalen, die gleichen Möglichkeiten haben.")
                                .monospaced()
                            
                            HStack {
                                Image(systemName: "person.3.fill")
                                    .foregroundColor(.green)
                                Text("Vielfalt und Inklusion")
                                    .monospaced()
                                    .font(.headline)
                            }
                            Text("Vielfalt am Arbeitsplatz ist ein wichtiger Faktor für den Erfolg eines Unternehmens. Bei DEV-MATCH fördern wir eine inklusive Kultur, die Menschen unterschiedlicher Hintergründe willkommen heißt.")
                                .monospaced()
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    CompanyInfoView()
}
