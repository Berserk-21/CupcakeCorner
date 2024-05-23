//
//  Order.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import Foundation

@Observable
class Order: Codable {
    
    static let allTypes = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestsEnabled = "specialRequestsEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _address = "address"
    }
    
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
    var address: Address {
        didSet {
            if let encoded = try? JSONEncoder().encode(address) {
                UserDefaults.standard.setValue(encoded, forKey: "address")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "address"), let address = try? JSONDecoder().decode(Address.self, from: data) {
            self.address = address
            return
        }
        
        address = Address()
    }
    
    var disableCheckout: Bool {
        
        // Check empty after trimming whitespaces
        if address.name.isEmptyAfterTrimming() || address.streetAddress.isEmptyAfterTrimming() || address.city.isEmptyAfterTrimming() || address.zip.isEmptyAfterTrimming() {
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

struct Address: Codable {
    // Address
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

extension String {
    
    /// Trims whitespaces then return the result of isEmpty check.
    func isEmptyAfterTrimming() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
