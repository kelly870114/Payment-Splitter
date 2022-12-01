//
//  CountryModel.swift
//  JDA Country Picker
//
//  Created by Jeevan on 04/07/20.
//  Copyright © 2020 JDA. All rights reserved.
//

import Foundation
import SwiftUI

struct CryptoCurr: Hashable {
    
    var code: String
    var name: String
    var usd: Double
    var icon: Image? {
        guard let bundlePath = Bundle.main.path(forResource: "CryptoCurrPicker", ofType: "bundle") else { return nil }
        guard let bundle = Bundle(path: bundlePath)  else { return nil }
        guard let imagePath = bundle.path(forResource: "Images/\(code.uppercased())", ofType: "png") else { return nil }
        guard let uiImage = UIImage(contentsOfFile: imagePath) else { return nil }
        return Image.init(uiImage: uiImage)
    }
    
    // Populates the metadata from the included json file resource
    //中括號？array?
    static func cryptoNamesByCode() -> [CryptoCurr] {
        var cryptos = [CryptoCurr]() //array
        if let bundlePath = Bundle.main.path(forResource: "CryptoCurrPicker", ofType: "bundle"),
            let bundle = Bundle(path: bundlePath),
            let jsonPath = bundle.path(forResource: "Data/cryptoCurrency", ofType: "json") {
         
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
              
                do {
                    
                    if let jsonObjects = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray {
                        
                        for jsonObject in jsonObjects {
                            
                            guard let countryObj = jsonObject as? NSDictionary else {  return cryptos }
                            
                            guard let code = countryObj["code"] as? String,
                                    let usd = countryObj["usd"] as? Double,
                                    let name = countryObj["name"] as? String else {
                                return cryptos
                            }
                            
                            let country = CryptoCurr(code: code, name: name, usd: usd)
                            cryptos.append(country)
                        }
                    }
                }
                catch {
                  print("Parsing json failed.")
                }
                
            }
        } else {
            print("Bundle not able to locate.")
        }
        
        return cryptos
    }
  
}
