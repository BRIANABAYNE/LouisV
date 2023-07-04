//
//  BagModel.swift
//  LouisV1
//
//  Created by Briana Bayne on 7/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Bag: Codable {
    @DocumentID var id: String? // 
    let name: String
    let price: Double
    let season: String
    let location: String
    let gender: String
    let collectionType: String 
    let size: Size
    let colors: [Color]
}

struct Size: Codable {
    
    var small: String
    var medium: String
    var large: String
}


struct Color: Codable {
    
    var colorName: String
    
}




//DatingApp
//
//let name:
//let occupation:
//let age:
//let bio:
//let location:
//let genderPrefernces:
//let typeOfRelationship:




