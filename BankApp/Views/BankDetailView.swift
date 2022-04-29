//
//  BankDetailView.swift
//  BankApp
//
//  Created by Sümeyye Kazancı on 28.04.2022.
//

import SwiftUI
import CoreLocation
import Firebase

struct BankDetailView: View {
    let item: Bank
    @State private var showingAlert = false
    
    var body: some View {
        VStack (alignment: .center, spacing: 20){
//            Image(systemName: "xmark.circle")
//                    .resizable()
//                    .frame(maxWidth: 300, maxHeight: 300)
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(Color.black)
//                    .padding()
            Divider()
            Text("\(item.bankaSube ?? "Şube") \(item.bankaKodu ?? "Banka kodu")")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            Divider()
            VStack(alignment: .leading) {
                Text("**Adres:** \(item.adres ?? "Adres")")
//                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom,10)
                Text("**Bölge Kordinatörlüğü:** \(item.bolgeKord ?? "BK")")
//                        .font(.subheadline)
                        .padding(.bottom,10)
                Text("**En Yakın ATM Adresi:** \(item.atm ?? "Atm")")
                    .multilineTextAlignment(.leading)
                        .lineLimit(20)
                        .padding(.bottom,10)
                Text("**Posta Kodu:** \(item.postaKodu ?? "Posta kodu")")
//                        .font(.subheadline)
                        .padding(.bottom,10)
            }
            .lineSpacing(1)
            Button("Haritada Göster") {
                let address = item.adres ?? "none"
                if address != "none" {
                    getCoordsFromAddress(address: address) { result in
                        if result == "error" {
                            showingAlert = true
                        }
                    }
                }else {
                    showingAlert = true
                }
                
            }
            .buttonStyle(CustomButton())
            .alert("Adres bulunamadı", isPresented: $showingAlert) {
                Button("Kapat", role: .cancel) { }
            }
            Spacer()
        }
        .onAppear() {
            //Firebase log event
            Analytics.logEvent("detail_screen_viewed", parameters: [
              AnalyticsParameterScreenName: "bank_detail_view",
              "banka_sube": item.bankaSube as Any,
              "banka_kodu": item.bankaKodu as Any,
              "banka_adres": item.adres as Any,
              "banka_tipi": item.bankaTipi as Any,
            ])
        }.navigationBarTitle(Text(item.adresAdi ?? "Şube Detay"),displayMode: .inline)
    }
    
    func getCoordsFromAddress(address: String,completion: @escaping (String)->Void) {
        let geocoder = CLGeocoder.init()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if error == nil {
                guard let placemark = placemarks?.first else { return }
                guard let lat = placemark.location?.coordinate.latitude else { return }
                guard let lon = placemark.location?.coordinate.longitude else { return }
                print("lat \(lat), lon \(lon)")
                let path = "maps://?saddr=&daddr=\(lat),\(lon)"
                if let url = URL(string: path) {
                    if UIApplication.shared.canOpenURL(url) {
                          UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                } else {
                    // Could not construct url. Handle error.
                }
                completion("success")
            }else{
                completion("error")
            }
        }
        
    }
}

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct BankDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BankDetailView(item: Bank(id: 1, sehir: "İzmir"))
    }
}
