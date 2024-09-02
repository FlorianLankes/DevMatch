//
//  LoginView.swift
//  DevMatch
//
//  Created by Florian Lankes on 02.07.24.
//

import SwiftUI

// Die Hauptansicht für die Anmeldung und Registrierung von Benutzern.
// Es unterstützt sowohl normale Benutzer als auch Arbeitgeber, die sich registrieren oder anmelden möchten.
struct LoginView: View {
    // Enum zur Unterscheidung zwischen Registrierung und Anmeldung.
    private enum Mode {
        case registration
        case login
        
        var mainButtonText: String {
            switch self {
            case .registration:
                return "Registrieren"
            case .login:
                return "Anmelden"
            }
        }
        var alternativButtonText: String {
            switch self {
            case .registration:
                return "Du hast schon einen Account?\nJetzt zur Anmeldung"
            case .login:
                return "Du hast noch keinen Account?\nJetzt Registrieren"
            }
        }
        mutating func toggle() {
            switch self {
            case .registration:
                self = .login
            case .login:
                self = .registration
            }
        }
    }
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    @State private var nickname: String = ""
    @State private var companyName: String = ""
    @State private var companyLocation: String = ""
    @State private var isEmployer: Bool = false
    @State private var hidePassword: Bool = true
    @State private var mode: Mode = .login
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                TextField("Email-Adresse", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                if case .registration = mode {
                    if isEmployer {
                        TextField("Firmenname", text: $companyName)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        TextField("Firmenstandort", text: $companyLocation)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                    } else {
                        TextField("Nickname", text: $nickname)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                    }
                }
                HStack {
                    ZStack {
                        if hidePassword {
                            SecureField("Passwort", text: $password)
                                .textFieldStyle(.roundedBorder)
                        } else {
                            TextField("Passwort", text: $password)
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                hidePassword.toggle()
                            }) {
                                Image(systemName: hidePassword ? "eye.slash" : "eye")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }.padding()
                if case .registration = mode {
                    SecureField("Passwort (Wiederholung)", text: $passwordCheck)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                if let passwordError = loginViewModel.passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                }
                Spacer()
                Toggle("Registrierung als Arbeitgeber", isOn: $isEmployer)
                Spacer()
                Button(action: {
                    switch mode {
                    case .registration:
                        if isEmployer {
                            loginViewModel.registerEmployer(
                                email: email,
                                companyName: companyName,
                                companyLocation: companyLocation,
                                password: password,
                                passwordCheck: passwordCheck
                            )
                        } else {
                            loginViewModel.register(
                                email: email,
                                nickname: nickname,
                                password: password,
                                passwordCheck: passwordCheck,
                                companyName: companyName,
                                companyLocation: companyLocation
                            )
                        }
                    case .login:
                        loginViewModel.login(
                            email: email,
                            password: password
                        )
                    }
                    
                }){
                    Text(mode.mainButtonText)
                }
                Divider().padding(20)
                Spacer()
                Button(action: {
                    withAnimation(.none) {
                        mode.toggle()
                    }
                }) {
                    Text(mode.alternativButtonText)
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
