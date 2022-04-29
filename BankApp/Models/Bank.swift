//
//  Bank.swift
//  BankApp
//
//  Created by Sümeyye Kazancı on 27.04.2022.
//

import Foundation

struct BankList: Decodable {
    var items: [Bank]?
}

struct Bank: Decodable, Hashable {
    var id: Int
    var sehir: String
    var ilce: String?
    var bankaSube: String?
    var bankaTipi: String?
    var bankaKodu: String?
    var adresAdi: String?
    var adres: String?
    var postaKodu: String?
    var onOffLine: String?
    var onOffSite: String?
    var bolgeKord: String?
    var atm: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case sehir = "dc_SEHIR"
        case ilce = "dc_ILCE"
        case bankaSube = "dc_BANKA_SUBE"
        case bankaTipi = "dc_BANKA_TIPI"
        case bankaKodu = "dc_BANK_KODU"
        case adresAdi = "dc_ADRES_ADI"
        case adres = "dc_ADRES"
        case postaKodu = "dc_POSTA_KODU"
        case onOffLine = "dc_ON_OFF_LINE"
        case onOffSite = "dc_ON_OFF_SITE"
        case bolgeKord = "dc_BOLGE_KOORDINATORLUGU"
        case atm = "dc_EN_YAKIM_ATM"
    }
}
