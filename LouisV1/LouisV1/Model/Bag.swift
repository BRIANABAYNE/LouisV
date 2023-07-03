//
//  BagModel.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/3/23.
//

import Foundation


struct Bag {
    
    let name: String
    let price: Double
    let season: String
    let location: String
    let gender: String
    let uuid: String = UUID().uuidString
// For setting the data - Writing 
    var bagDictionaryReprentation: [String: AnyHashable] {
        
        ["name": self.name,
         "price": self.price,
         "season": self.season,
         "location": self.location,
         "gender":self.gender,
         "uuid":self.uuid]
        
    }
    
}
