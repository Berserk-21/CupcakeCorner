//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI

struct CheckoutView: View {
    
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
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
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .alert("Thank you!", isPresented: $showingConfirmation, actions: {
            Button("OK") {}
        }, message: {
            Text(confirmationMessage)
        })
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    func placeOrder() async {
        
        guard let encodedData = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            print("Failed to create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.allTypes[decodedOrder.type].lowercased()) cupcakes is on it's way!"
            showingConfirmation = true
            
        } catch {
            print("Failed to upload encoded data: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    CheckoutView(order: Order())
}
