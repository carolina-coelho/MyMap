//
//  HomeView.swift
//  MyMap
//
//  Created by stud on 06/11/2025.
//
import MapKit
import SwiftUI

struct HomeView: View {
    let home = Home(tittle: "")
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
    
    var body: some View {
        Text(home.tittle)
        Map(initialPosition: .region(region))
    }
}
