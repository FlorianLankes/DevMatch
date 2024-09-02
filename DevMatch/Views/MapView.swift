//
//  MapView.swift
//  DevMatch
//
//  Created by Florian Lankes on 18.07.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @EnvironmentObject private var arbeitsagenturViewModel: ArbeitsagenturViewModel
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // SwiftUI's `Map` zeigt die Karte an, die Position der Kamera wird durch `viewModel.mapCameraPosition` gesteuert.
                Map(position: $viewModel.mapCameraPosition) {
                    // Für jedes Jobangebot im `arbeitsagenturViewModel.jobs` wird eine Annotation auf der Karte platziert.
                    ForEach(arbeitsagenturViewModel.jobs) { job in
                        // `Annotation` zeigt ein Symbol oder benutzerdefinierte Ansicht an den angegebenen Koordinaten.
                        Annotation("", coordinate: .init(
                            latitude:
                                job.arbeitsort?.koordinaten?.lat ?? 0,
                            longitude:
                                job.arbeitsort?.koordinaten?.lon ?? 0)) {
                            NavigationLink(destination: JobDetailView(job: job)) {
                                VStack {
                                    Image("logoMap")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(20)
                                    Text(job.beruf)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    UserAnnotation()
                }
                .mapControls {
                    MapCompass()
                    MapScaleView()
                    MapUserLocationButton()
                }
            }
        }
    }
}


#Preview {
    MapView()
        .environmentObject(ArbeitsagenturViewModel())
}
