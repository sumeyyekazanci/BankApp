//
//  BankAppApp.swift
//  BankApp
//
//  Created by Sümeyye Kazancı on 27.04.2022.
//

import SwiftUI
import Firebase

@main
struct BankAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
