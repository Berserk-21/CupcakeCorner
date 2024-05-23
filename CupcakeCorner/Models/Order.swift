//
//  Order.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestsEnabled = "specialRequestsEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
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
        
        // Check only whitespaces
        if name.trimmingCharacters(in: .whitespaces).count == 0 || streetAddress.trimmingCharacters(in: .whitespaces).count == 0 || city.trimmingCharacters(in: .whitespaces).count == 0 || zip.trimmingCharacters(in: .whitespaces).count == 0 {
            return true
        }
        
        // Check isEmpty
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return true
        }
        
        return false
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
