//
//  NetworkManager.swift
//  BankApp
//
//  Created by Sümeyye Kazancı on 27.04.2022.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    let nwPathMonitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = false
    var desc: String {
        return isConnected ? "Network is available" : "Connection is not available"
    }
    
    init() {
        nwPathMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        nwPathMonitor.start(queue: queue)
    }
}
