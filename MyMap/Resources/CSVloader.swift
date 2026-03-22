import Foundation

struct CSVLoader {
    static func loadWorldCities() -> [Country] {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "csv") else {
            print("cities.csv not found in bundle")
            return []
        }

        do {
            print("start")
            let raw = try String(contentsOf: url, encoding: .utf8)
            let lines = raw.components(separatedBy: "\n")

            var countriesDict: [String: [City]] = [:]

            for line in lines {
                var columns = line.components(separatedBy: ",")
                
                columns = columns.map { column in
                                    column.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\"", with: "")
                                }

                if columns.count > 1 {
                    let cityName = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    let countryName = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    let description = columns[2].trimmingCharacters(in: .whitespacesAndNewlines)

                    if cityName.isEmpty || countryName.isEmpty { continue }

                    let city = City(name: cityName, country: countryName,description: description)

                    countriesDict[countryName, default: []].append(city)
                }
            }

            let countries = countriesDict.map { key, value in
                Country(name: key, cities: value.sorted { $0.name < $1.name })
            }
            

            return countries.sorted { $0.name < $1.name }
        }
        catch {
            print("Error reading worldcities.csv:", error)
            return []
        }
    }
}
