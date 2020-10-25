//
//  Conversion.swift
//  CurrencyExchange
//
//  Created by Maxim Macari on 25/10/2020.
//

import SwiftUI

//For fetching data
struct Conversion: Decodable {
    
    var rates: [String: Double]
    var date: String
    var base: String
    
    
}

