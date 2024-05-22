//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        
        print(str)
    }
}

@Observable
class User: Codable {
    var name = "Taylor"
    
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
}

#Preview {
    ContentView()
}
