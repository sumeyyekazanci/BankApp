//
//  OfflineView.swift
//  BankApp
//
//  Created by Sümeyye Kazancı on 30.04.2022.
//

import SwiftUI

struct OfflineView: View {
    var body: some View {
        VStack {
            Image(systemName: "wifi.slash")
                .resizable()
                .frame(maxWidth: 200, maxHeight: 200)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.blue)
                .padding()
            
            Text("İnternet bağlantınız kontrol edin")
                .font(.headline)
        }
    }
}

struct OfflineView_Previews: PreviewProvider {
    static var previews: some View {
        OfflineView()
    }
}
