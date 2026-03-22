import SwiftUI

struct AddView: View {
    @State private var searchText = ""
    @EnvironmentObject var visitedCountriesModel: VisitedCountriesModel

    let allCountries: [Country] = CSVLoader.loadWorldCities()
    
    var filteredCountries: [Country] {
        if searchText.isEmpty { return allCountries }
        return allCountries.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.cities.contains { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredCountries) { country in
                Section {
                    ForEach(country.cities) { city in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(city.name)
                                    .font(.body)
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                            
                            Button {
                                visitedCountriesModel.addCity(city, to: country)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title3)
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundColor(.red) 
                            }
                            .buttonStyle(.borderless) 
                        }
                        .padding(.vertical, 2)
                    }
                } header: {
                    Text(country.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .textCase(nil) 
                }
            }
            .listStyle(.insetGrouped)
            
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search country or city...")
            
            .navigationTitle("Add Country")
        }
    }
}
