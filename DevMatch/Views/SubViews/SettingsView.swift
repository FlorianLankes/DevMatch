//
//  SettingsView.swift
//  DevMatch
//
//  Created by Florian Lankes on 23.07.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button("Logout", systemImage: "power.circle") {
                        loginViewModel.logout()
                    }
                    .foregroundColor(.yellow)
                    Button("Account löschen", systemImage: "trash") {
                        //                        loginViewModel.delateFireUseer { }
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Einstellungen")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LoginViewModel())
}
