//
//  JobDetailView.swift
//  DevMatch
//
//  Created by Florian Lankes on 17.07.24.
//

import SwiftUI

struct JobDetailView: View {
    
    @StateObject private var likeViewMeodel = MerklistViewModel()
    @State private var likeIsMarked: Bool = false
    @State private var showSettings = false
    
    var job: ArbeitsagenturSearchResult.Stellenangebot
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.cyan.opacity(0.8), Color.yellow.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(job.arbeitgeber)
                            .font(.title)
                            .monospaced()
                            .bold()
                            .shadow(color: .black, radius: 3, x: 0, y: 10)
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .mask(Text(job.arbeitgeber)
                                        .font(.title)
                                        .monospaced()
                                        .bold()
                                        .shadow(color: .black, radius: 3, x: 5, y: 5)
                                    )
                            )
                        Text(job.titel ?? "Kein Titel angegeben")
                            .font(.title2)
                            .foregroundColor(.cyan)
                            .bold()
                            .padding(.bottom, 5)
                            .monospaced()
                        GroupBox(label:
                                    HStack {
                            Image(systemName: "building.2")
                                .foregroundColor(.yellow)
                            Text("Firmen Daten")
                                .foregroundColor(.cyan)
                                .monospaced()
                        }
                        ) {
                            VStack(alignment: .leading, spacing: 10) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("Firmenname:")
                                        .font(.headline)
                                        .monospaced()
                                    Text(job.arbeitgeber)
                                    Divider()
                                    Spacer()
                                    Text("Stadt:")
                                        .font(.headline)
                                        .monospaced()
                                    Text(job.arbeitsort?.ort ?? "Keine Angabe")
                                    Divider()
                                    Spacer()
                                    Text("Postleitzahl:")
                                        .font(.headline)
                                        .monospaced()
                                    Text(job.arbeitsort?.plz ?? "Keine Angabe")
                                    Divider()
                                    Spacer()
                                    Text("Bundesland:")
                                        .monospaced()
                                        .font(.headline)
                                    Text(job.arbeitsort?.region ?? "Keine Angabe")
                                    Divider()
                                    Spacer()
                                    Text("Land:")
                                        .monospaced()
                                        .font(.headline)
                                    Text(job.arbeitsort?.land ?? "Keine Angabe")
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                        }
                        .groupBoxStyle(CustomGroupBoxStyle(color: .yellow, opacity: 0.2))
                        GroupBox(label:
                                    HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.yellow)
                            Text("Jobinformationen")
                                .foregroundColor(.cyan)
                                .monospaced()
                        }
                        ) {
                            VStack(alignment: .leading, spacing: 10) {
                                VStack(alignment: .leading) {
                                    Text("Berufsbezeichnung:")
                                        .font(.headline)
                                        .monospaced()
                                    Text(job.titel ?? "Kein Titel angegeben")
                                }
                                Divider()
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Eintrittsdatum:")
                                        .font(.headline)
                                        .monospaced()
                                    Text(job.eintrittsdatum)
                                }
                                Divider()
                                Spacer()
                                Text("Zur Stellenbeschreibung")
                                    .font(.headline)
                                    .monospaced()
                                if let externeUrlString = job.externeUrl, let url = URL(string: externeUrlString) {
                                    Link(destination: url) {
                                        Text("...hier clicken!")
                                            .monospaced()
                                            .font(.headline)
                                            .foregroundColor(.yellow)
                                    }
                                } else {
                                    Text("Upps! Hier haben wir leider keine Info")
                                        .monospaced()
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                        }
                        .groupBoxStyle(CustomGroupBoxStyle(color: .cyan, opacity: 0.2))
                    }
                    .padding()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    likeViewMeodel.createNewMerklistItem(title: job.titel ?? "Kein Titel angegeben", arbeitgeber: job.arbeitgeber, beruf: job.titel ?? "Kein Titel angegeben", plz: job.arbeitsort?.plz, ort: job.arbeitsort!.ort!, jobId: job.id)
                    likeIsMarked.toggle()
                }) {
                    Label(likeIsMarked ? "Gemerkt" : "Merken", systemImage: likeIsMarked ? "heart.fill" : "heart")
                        .foregroundColor(likeIsMarked ? .pink : .primary)
                }
            }
        }
    }
}

struct CustomGroupBoxStyle: GroupBoxStyle {
    var color: Color
    var opacity: Double
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.headline)
                .padding(.bottom, 5)
            configuration.content
                .padding()
                .background(color.opacity(opacity))
                .cornerRadius(10)
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
}

//#Preview {
//    JobDetailView(job: job)
//}
