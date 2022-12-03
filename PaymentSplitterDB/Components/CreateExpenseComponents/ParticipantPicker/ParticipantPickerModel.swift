//
//  CountryModel.swift
//  JDA Country Picker
//
//  Created by Jeevan on 04/07/20.
//  Copyright © 2020 JDA. All rights reserved.
//

import Foundation
import SwiftUI

struct Participant: Hashable {
    
    var code: String
    var name: String
    var icon: Image? {
        guard let bundlePath = Bundle.main.path(forResource: "ParticipantPicker", ofType: "bundle") else { return nil }
        guard let bundle = Bundle(path: bundlePath)  else { return nil }
        guard let imagePath = bundle.path(forResource: "Images/\(code)", ofType: "jpg") else { return nil }
        guard let uiImage = UIImage(contentsOfFile: imagePath) else { return nil }
        return Image.init(uiImage: uiImage)
    }
    
    // Populates the metadata from the included json file resource
    //中括號？array?
    static func participantNamesByCode() -> [Participant] {
        var participants = [Participant]() //array
        if let bundlePath = Bundle.main.path(forResource: "ParticipantPicker", ofType: "bundle"),
            let bundle = Bundle(path: bundlePath),
            let jsonPath = bundle.path(forResource: "Data/participantData", ofType: "json") {
         
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
              
                do {
                    
                    if let jsonObjects = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray {
                        
                        for jsonObject in jsonObjects {
                            
                            guard let partObj = jsonObject as? NSDictionary else {  return participants }
                            
                            guard let code = partObj["code"] as? String,
                                    let name = partObj["name"] as? String else {
                                return participants
                            }
                            
                            let participant = Participant(code: code, name: name)
                            participants.append(participant)
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
        
        return participants
    }
  
}
