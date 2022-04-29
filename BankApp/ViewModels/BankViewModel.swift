//
//  BankViewModel.swift
//  BankApp
//
//  Created by Sümeyye Kazancı on 27.04.2022.
//

import Foundation

class BankViewModel: ObservableObject {
    let urlString = "https://raw.githubusercontent.com/fatiha380/mockjson/main/bankdata"
    @Published var items = [Bank]()
    @Published var isLoading = true
    
    init() {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, res, error in
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONDecoder().decode([Bank].self, from: data)
                print(json.count)
                DispatchQueue.main.async {
                    self.items = json
                    self.isLoading = false
                }
            }catch {
                print("Failed to decode \(error)")
            }

        }.resume()
    }
}
