//
//  Country.swift
//  MyMap
//
//  Created by stud on 23/10/2025.
//
import Foundation
import SwiftUI

struct Country: Codable, Identifiable{
    var id = UUID()
    var name: String
    var cities: [City]
    var continentsVisited: [String] = []
    
}
