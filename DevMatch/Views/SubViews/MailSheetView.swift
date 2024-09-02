//
//  MailView.swift
//  DevMatch
//
//  Created by Florian Lankes on 19.08.24.
//

import SwiftUI

struct MailSheetView: View {
    
    @ObservedObject private var employerProfielViewModel = FireEmployerViewModel()
    @ObservedObject private var applicantProfielViewModel = FireApplicantProfilViewModel()
    
    @State private var employerProfil: FireEmployerProfile?
    
    var body: some View {
        VStack {
            if employerProfielViewModel.employerProfilItem.isEmpty{
                Text("Du hast noch keine Nachrichten bekommen")
                    .monospaced()
            } else {
                List(employerProfielViewModel.employerProfilItem) { item in
                    if (employerProfil?.userId.first(where: { $0.description == item.userId})) != nil {
                        VStack(alignment: .leading) {
                            Spacer(minLength: 2)
                            Text(employerProfil?.companyName ?? "Nicht angegeben")
                                .font(.headline)
                                .monospaced()
                                .bold()
                            Text(employerProfil?.job ?? "Nicht angegeben")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(employerProfil?.city ?? "Nicht angegeben")
                        }
                    }
                }                
            }
        }
        .onAppear {
            applicantProfielViewModel.fetchEmployerContact()
        }
    }
    
}





#Preview {
    MailSheetView()
}
