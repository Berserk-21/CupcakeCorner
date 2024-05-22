//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Type") {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.allTypes.indices, id: \.self) {
                            Text(Order.allTypes[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity)
                }
                
                Section("") {
                    Toggle("Any special requests ?", isOn: $order.specialRequestsEnabled)
                    
                    if order.specialRequestsEnabled {
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                        Toggle("Sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section() {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
