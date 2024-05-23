//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI

struct CheckoutView: View {
    
    var order: Order
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .font(.title)
                Button("Place Order") {
                    orderNow()
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    func orderNow() {
        print("order now !")
    }
}

#Preview {
    CheckoutView(order: Order())
}
