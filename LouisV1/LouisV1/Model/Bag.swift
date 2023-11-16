//
//  BagModel.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Bag: Codable {
    @DocumentID var id: String? 
    var name: String
    var price: Double
    var season: String
    var location: String
    var gender: String
    var collectionType: String
    var size: Size
    var colors: [Color] 
}

struct Size: Codable {
    
    var small: String
    var medium: String
    var large: String
}

struct Color: Codable {
    
    var colorName: String
    
}
