//
//  NewsDetailVivew.swift
//  DevMatch
//
//  Created by Florian Lankes on 26.07.24.
//

import SwiftUI

struct NewsDetailView: View {
    
    var article: Articel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(
                        url: article.urlToImage,
                        content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 380, height: 250)
                                .clipped()
                                .cornerRadius(25)
                        },
                        placeholder: {
                            Image("logoMap")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .padding()
                        }
                    )
                    .padding(.horizontal)
                    Text(article.title ?? "Nicht vorhanden")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    Text(article.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    Link(destination: URL(string: article.url)!) {
                        Text("...weiter lesen")
                            .font(.body)
                            .foregroundColor(.yellow)
                    }
                    .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Author:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(article.author)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Text("Published at:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(article.publishedAt)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Article Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
//#Preview {
//    NewsDetailVivew(articel: Articel)
//}
