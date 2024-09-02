//
//  NewsView.swift
//  DevMatch
//
//  Created by Florian Lankes on 25.07.24.
//

import SwiftUI

struct NewsView: View {
    @StateObject private var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List (newsViewModel.articels, id: \.title) {articel in
                NavigationLink(destination: NewsDetailView(article: articel)) {
                    HStack {
                        AsyncImage (
                            url: articel.urlToImage,
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                    .clipped()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.yellow, lineWidth: 2)
                                            .shadow(radius: 20)
                                    )
                            },
                            placeholder: {
                                Image("logo")
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .frame(width: 100, height: 100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.yellow, lineWidth: 4)
                                    )
                            }
                        )
                        .padding(.trailing, 10)
                    }
                    VStack(alignment: .leading) {
                        Text(articel.title ?? "Kein titel")
                            .font(.headline)
                            .monospaced()
                            .overlay(
                                LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .mask(Text(articel.title ?? "Kein titel")
                                        .font(.headline)
                                        .monospaced()
                                    )
                            )
                    }
                    .padding(.vertical, 5)
                }
                .listRowSeparatorTint(Color.cyan)
            }
            .onAppear{
                newsViewModel.loadeTechNews()
            }
            .navigationTitle("Dev-News")
        }
    }
}

#Preview {
    NewsView()
}
