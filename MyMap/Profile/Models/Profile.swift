//
//  Profile.swift
//  MyMap
//
//  Created by stud on 23/10/2025.
//
import Foundation
import SwiftUI

struct Profile: Identifiable, Codable{
    var id = UUID()
    var name : String
    var age: Int
    var favCountry: String
    var countriesVisited : [String]
    var citiesvisited: [String]
       
   var profileImageData: Data?
}

