//
//  Home.swift
//  CurrencyExchange
//
//  Created by Maxim Macari on 25/10/2020.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var viewModel = FetchData()
    
    var body: some View {
        
        VStack {
            
            if viewModel.conversionData.isEmpty{
                ProgressView()
            }else{
                ScrollView{
                    //Detch data
                    LazyVStack(alignment: .leading, spacing: 15, content:  {
                        ForEach(viewModel.conversionData) { rate in
                            HStack(spacing: 15) {
                                
                                Text(getFlag(currencyAbrev: rate.currencyName))
                                    .font(.title)
                                    .fontWeight(.heavy)
                                
                                VStack(alignment: .leading, spacing: 5){
                                    Text(rate.currencyName)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text("\(rate.currencyValue)")
                                        .fontWeight(.heavy)
                                }
                            }
                            .padding(.horizontal)
                            Divider()
                        }
                    })
                    .padding(.top)
                    
                    
                }
            }
        }
        .toolbar(content: {
            Menu(content: {
                ForEach(currencies, id: \.self){ name in
                    Button(action: {
                        viewModel.updateData(base: name)
                    }, label: {
                        HStack{
                            Text(getFlag(currencyAbrev: name) + " - \(name)")
                                .foregroundColor(.primary)
                            
                            
                            if (viewModel.base == name){
                                Image(systemName: "arrowtriangle.left.fill")
                            }
                            
                        }
                        
                        
                    })
                    
                    
                }
                
                
            }) {
                Text(getFlag(currencyAbrev: viewModel.base))
                
                Text("Base: \(viewModel.base)")
                    .fontWeight(.heavy)
                
                Divider()
                
            }
        })
        
    }
    
    
    
    //getting country flag by currency name
    //How to get flag name by currencyCode
    //Currency code = USD
    //Flag code = US
    //Remove the last letter from currency will result in flag code.
    
    func getFlag(currencyAbrev: String) -> String{
        
        var base = 127397
        
        var code = currencyAbrev
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        
        for i in code.utf16{
            scalar.append(UnicodeScalar(base + Int(i))!)
        }
        
        return String(scalar)
        
        
    }
    
    
    
}

