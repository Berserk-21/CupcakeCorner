//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var counter = 0
    
    var body: some View {
        List {
            HapticButton(sensoryFeedback: .decrease)
            HapticButton(sensoryFeedback: .increase)
            HapticButton(sensoryFeedback: .error)
            HapticButton(sensoryFeedback: .impact)
            HapticButton(sensoryFeedback: .levelChange)
            HapticButton(sensoryFeedback: .pathComplete)
            HapticButton(sensoryFeedback: .selection)
            HapticButton(sensoryFeedback: .start)
            HapticButton(sensoryFeedback: .stop)
            HapticButton(sensoryFeedback: .success)
            HapticButton(sensoryFeedback: .warning)
        }
    }
}

struct HapticButton: View {
    
    var sensoryFeedback: SensoryFeedback
    @State private var counter = 0
    
    var body: some View {
        Button("\(sensoryFeedback)") {
            counter += 1
        }
        .sensoryFeedback(sensoryFeedback, trigger: counter)
    }
}

#Preview {
    ContentView()
}
