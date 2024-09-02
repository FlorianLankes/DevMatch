//
//  DevMatchApp.swift
//  DevMatch
//
//  Created by Florian Lankes on 01.07.24.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct DevMatchApp: App {
    
    // StateObjects für das Login und die Arbeitsagentur-Verwaltung
    @StateObject private var loginViewModel = LoginViewModel()
    @StateObject private var arbeitsagenturViewModel = ArbeitsagenturViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
           WindowGroup {
               if loginViewModel.isUserLoggedIn {
                   // Überprüfe, ob der Benutzer einen Nicknamen oder Firmennamen hat
                   if let user = loginViewModel.user {
                       if let nickname = user.nickname, !nickname.isEmpty {
                           MainTabView()
                               .environmentObject(loginViewModel)
                               .environmentObject(arbeitsagenturViewModel)
                       } else if let companyName = user.companyName, !companyName.isEmpty {
                           CompanyTabView()
                               .environmentObject(loginViewModel)
                       } else {
                           Text("Fehler: Benutzerinformationen fehlen.")
                       }
                   }
               } else {
                   LoginView()
                       .environmentObject(loginViewModel)
               }
           }
       }
   }


//MARK: - ArbeitnehmerTab

struct MainTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ArbeitsargenturView()
                    .tabItem {
                        Label("Jobs", systemImage: "briefcase.fill")
                    }
                    .tag(0)
                MerklistView()
                    .tabItem {
                        Label("Merkliste", systemImage: "list.bullet.clipboard.fill")
                    }
                    .tag(1)
                ProfilFormView()
                    .tabItem {
                        Label("Finden lassen", systemImage: "figure.wave")
                    }
                    .tag(2)
                MapView()
                    .tabItem {
                        Label("Maps", systemImage: "globe.europe.africa")
                    }
                    .tag(3)
                NewsView()
                    .tabItem {
                        Label("Dev-News", systemImage: "newspaper")
                    }
                    .tag(4)
            }
            .accentColor(.yellow .opacity(0.8))
            // Ein benutzerdefinierter Button für "finden lasssen"
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        selectedTab = 2
                    }) {
                        Image(systemName: "figure.wave")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .foregroundColor(.yellow)
                            .background(Circle().foregroundColor(.cyan.opacity(0.8)))
                            .shadow(radius: 10)
                    }
                    .offset(y: -20)
                    Spacer()
                }
            }
        }
    }
}

//MARK: - ArbeitgeberTab
struct CompanyTabView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ApplicantView()
                    .tabItem {
                        Label("Mitarbeiter finden", systemImage: "person.line.dotted.person")
                    }
                    .tag(0)
                NewsView()
                    .tabItem {
                        Label("Dev-News", systemImage: "newspaper")
                    }
                    .tag(1)
            }
            .accentColor(.yellow.opacity(0.8)) // Falls gewünscht, kannst du die Akzentfarbe anpassen
        }
    }
}
