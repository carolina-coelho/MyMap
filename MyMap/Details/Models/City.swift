//
//  City.swift
//  MyMap
//
//  Created by stud on 23/10/2025.
//
import Foundation
import SwiftUI

struct City: Identifiable, Codable{
    var id = UUID ()
    var name: String
    var country: String
    var description: String = ""
    
    var imageData: Data? 
}

