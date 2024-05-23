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
    
    // Price
    var cost: Double {
        
        // 2$ per cake
        var cost = 2 * Double(quantity)
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // 1$ per extraFrosting
        if extraFrosting {
            cost += (1 * Double(quantity))
        }
        
        // 0.5$ per extraFrosting
        if addSprinkles {
            cost += (0.5 * Double(quantity))
        }
        
        return cost
    }
}
