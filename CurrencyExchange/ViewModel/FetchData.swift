//
//  FetchData.swift
//  CurrencyExchange
//
//  Created by Maxim Macari on 25/10/2020.
//

import SwiftUI

class FetchData: ObservableObject {
    @Published var conversionData: [Currency] = []
    @Published var base = "EUR"
    
    init()
    {
        fetch()
    }
    func fetch(){
        
        let urlString = "https://api.exchangeratesapi.io/latest?base=\(self.base)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { (data, res, err) in
            
            guard let JSONData = data else {
                return
            }
            do {
               
                let conversion = try JSONDecoder().decode(Conversion.self, from: JSONData)
                
                //converting dioctionary to array of objects
                // value will be currency value
                DispatchQueue.main.async {
                    self.conversionData = conversion.rates.compactMap({ (key, value) -> Currency? in
                        return Currency(currencyName: key, currencyValue: value)
                    })
                }
                
                
            }catch{
                print(error.localizedDescription)
            }
            
        }
        .resume()
        
        
    }
    
    func updateData(base: String){
        
        self.base = base
        self.conversionData.removeAll()
        self.fetch()
        
    }
}


