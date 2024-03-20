//
//  BoxCalcApp.swift
//  BoxCalc
//
//  Created by Chris Milne on 19/02/2024.
//

import SwiftUI

@main
struct BoxCalcApp: App {
    @StateObject var size = Sizes()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(size)
        }
    }
}
