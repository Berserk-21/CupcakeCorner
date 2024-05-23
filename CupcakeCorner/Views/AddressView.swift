//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI

struct AddressView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Address", text: $order.address.streetAddress)
                TextField("City", text: $order.address.city)
                TextField("Zip code", text: $order.address.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.disableCheckout)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
