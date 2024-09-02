//
//  InfoView.swift
//  DevMatch
//
//  Created by Florian Lankes on 09.07.24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Info")
                        .font(.title)
                        .bold()
                        .monospaced()
                        .padding(.top, 40)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.orange)
                                Text("Genderneutralität")
                                    .monospaced()
                                    .font(.headline)
                            }
                            Text("DEV-MATCH legt großen Wert darauf, alle Bewerber*innen gleich zu behandeln, unabhängig von Geschlecht oder Geschlechtsidentität. Bitte verwende genderneutrale Begriffe und achte darauf, dass Deine Bewerbung keine geschlechtsspezifischen Angaben enthält.")
                                .monospaced()
                            
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.orange)
                                Text("Qualifikation im Mittelpunkt")
                                    .monospaced()
                                    .font(.headline)
                            }
                            Text("Bei uns zählt einzig und allein Deine Qualifikation. Eure Fähigkeiten, Erfahrungen und Kenntnisse stehen im Fokus unserer Bewertung. Angaben zu Religion, Herkunft oder persönlichen Hintergründen sind für uns nicht relevant und müssen nicht angegeben werden.")
                                .monospaced()
                            
                            HStack {
                                Image(systemName: "hand.raised.fill")
                                    .foregroundColor(.orange)
                                Text("Transparente und faire Bewertung")
                                    .monospaced()
                                    .font(.headline)
                            }
                            Text("Unser Auswahlverfahren ist darauf ausgerichtet, transparent und fair zu sein. Jede Bewerbung wird sorgfältig geprüft, um sicherzustellen, dass alle Bewerber*innen die gleichen Chancen haben.")
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
    InfoView()
}
