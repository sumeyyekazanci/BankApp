//
//  ContentView.swift
//  BankApp
//
//  Created by Sümeyye Kazancı on 27.04.2022.
//

import SwiftUI
import ActivityIndicatorView

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var bankVM = BankViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                ActivityIndicatorView(isVisible: $bankVM.isLoading, type: .equalizer(count: 5))
                    .foregroundColor(.blue)
                    .frame(width: 90, height: 90, alignment: .center)
                    
                ScrollView {
                    LazyVGrid(columns: [GridItem()],spacing: 15, content: {
                        ForEach(searchResults, id: \.self) { item in
                            VStack(alignment: .leading, spacing: 10, content: {
                                NavigationLink(destination: BankDetailView(item: item)) {
                                    Text(item.sehir).bold()
                                    Text(item.ilce ?? "").bold()
                                    Text(item.bankaKodu ?? "").bold()
                                }
                                
                                
                            })
                            .padding(.horizontal)
                            .frame(width: 400, height: 70, alignment: .leading)
                            .background(Color(.systemGray6))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            
                        }
                    })
                }
            }
            .searchable(text: $searchText,prompt: "Şehir Ara")
//            .background(Color(.systemGray6))
            .navigationBarTitle("Şubeler",displayMode: .inline)
        }
    }
    
    var searchResults: [Bank] {
        if searchText.isEmpty {
            return bankVM.items
        } else {
            return bankVM.items.filter { $0.sehir.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
