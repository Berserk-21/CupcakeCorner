//
//  Order.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI

@Observable
class Order {
    
    static let allTypes = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    // Product
    var type = 0
    var quantity = 3
    var specialRequestsEnabled = false {
        didSet {
            if specialRequestsEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    // Address
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var disableCheckout: Bool {
        return name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty
    }
}
