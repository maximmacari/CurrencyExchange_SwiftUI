//
//  Currency.swift
//  CurrencyExchange
//
//  Created by Maxim Macari on 25/10/2020.
//

import SwiftUI


struct Currency: Identifiable {
    
    var id = UUID().uuidString
    var currencyName: String
    var currencyValue: Double
    
    
    
}


var currencies = ["USD", "AUD","EUR", "INR", "JPY"]


