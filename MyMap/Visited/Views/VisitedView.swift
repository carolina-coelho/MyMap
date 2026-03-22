//
//  VisitedView.swift
//  MyMap
//
//  Created by stud on 30/10/2025.
//
import SwiftUI

struct VisitedView: View {
    @EnvironmentObject var visitedCountriesModel: VisitedCountriesModel
    
    
    var body: some View {
        NavigationView {
            List(visitedCountriesModel.visitedCountries) { country in
                Section(header: Text(country.name)) {
                    ForEach(country.cities) { city in
                        NavigationLink(destination: DetailsView(country: country, city: city)) {
                            HStack {
                                Text(city.name)
                                Spacer()
                                Button(action: {
                                    DetailsView(country: country, city: city)
                                }){ Text("Details")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Visited Countries")
        }
    }
}
