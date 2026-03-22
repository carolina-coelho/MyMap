import SwiftUI
internal import Combine

class VisitedCountriesModel: ObservableObject {
    @Published var visitedCountries: [Country] = []

    func addCity(_ city: City, to country: Country) {
        if let index = visitedCountries.firstIndex(where: { $0.name == country.name }) {
            if !visitedCountries[index].cities.contains(where: { $0.name == city.name }) {
                visitedCountries[index].cities.append(city)
            }
        } else {
            var newCountry = country
            newCountry.cities = [city]
            visitedCountries.append(newCountry)
        }
        
        print(visitedCountries)
    }
    
    func addContinent(_ continent: String, to country: Country) {
            if let index = visitedCountries.firstIndex(where: { $0.name == country.name }) {
                if !visitedCountries[index].continentsVisited.contains(continent) {
                    visitedCountries[index].continentsVisited.append(continent)
                }
            } else {
                var newCountry = country
                newCountry.continentsVisited = [continent]
                visitedCountries.append(newCountry)
            }
        }
}
