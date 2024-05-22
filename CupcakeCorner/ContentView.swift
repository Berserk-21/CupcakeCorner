//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading, content: {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
                
                // With error handling and placeholder
                AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 200, height: 200)
                    } else if phase.error != nil {
                        Text("There was an error loading the image.")
                    } else {
                        // Placeholder
                        ProgressView()
                    }
                }
                
                // With placeholder
                AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                    image
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaledToFit()
                } placeholder: {
                    Color.red
                }
                .frame(width: 200, height: 200)
            })
        }
        .task {
            await loadData()
        }
    }
    
    /// Gets a list of songs from itunes
    func loadData() async {
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("invalid url")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            self.results = try JSONDecoder().decode(Response.self, from: data).results
            
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
