//
//  VisitCountriesModelTests.swift
//  MyMapUITests
//
//  Created by stud on 26/01/2026.
//

import XCTest
@testable import MyMap

final class VisitCountriesModelTests: XCTestCase {
    
    func testVisitedCountriesStartsEmpty() {
        let model = VisitedCountriesModel()
        XCTAssertTrue(model.visitedCountries.isEmpty)
    }
    
    func testAddCityCreatesCountryAndIncrementsCounts() {
       let model = VisitedCountriesModel()

       let city = City(name: "Lisbon", country: "Portugal", description: "Capital")
       let country = Country(name: "Portugal", cities: [])

       model.addCity(city, to: country)

       XCTAssertEqual(model.visitedCountries.count, 1, "Devia existir 1 país após adicionar a primeira cidade")
       XCTAssertEqual(model.visitedCountries.first?.name, "Portugal")
       XCTAssertEqual(model.visitedCountries.first?.cities.count, 1, "O país devia ter 1 cidade")
       XCTAssertEqual(model.visitedCountries.first?.cities.first?.name, "Lisbon")
   }
    
    func testAddCityDoesNotDuplicateSameCity() {
        let model = VisitedCountriesModel()

        let country = Country(name: "Portugal", cities: [])
        let city = City(name: "Lisbon", country: "Portugal", description: "Capital")

        model.addCity(city, to: country)
        model.addCity(city, to: country)

        XCTAssertEqual(model.visitedCountries.count, 1)
        XCTAssertEqual(model.visitedCountries[0].cities.count, 1)
    }
    
    func testCityIsAddedToCorrectCountry() {
        let model = VisitedCountriesModel()

        let portugal = Country(name: "Portugal", cities: [])
        let spain = Country(name: "Spain", cities: [])

        let lisbon = City(name: "Lisbon", country: "Portugal", description: "")
        let madrid = City(name: "Madrid", country: "Spain", description: "")

        model.addCity(lisbon, to: portugal)
        model.addCity(madrid, to: spain)

        let portugalCities = model.visitedCountries.first { $0.name == "Portugal" }?.cities
        let spainCities = model.visitedCountries.first { $0.name == "Spain" }?.cities

        XCTAssertEqual(portugalCities?.count, 1)
        XCTAssertEqual(spainCities?.count, 1)
    }
    
    func testAddTwoDifferentCitiesToSameCountryKeepsOneCountry() {
        let model = VisitedCountriesModel()

        let portugal = Country(name: "Portugal", cities: [])
        let lisbon = City(name: "Lisbon", country: "Portugal", description: "")
        let porto = City(name: "Porto", country: "Portugal", description: "")

        model.addCity(lisbon, to: portugal)
        model.addCity(porto, to: portugal)

        XCTAssertEqual(model.visitedCountries.count, 1)
        XCTAssertEqual(model.visitedCountries[0].cities.count, 2)
    }

    func testCountryCodableRoundTrip() throws {
        let city = City(name: "Lisbon", country: "Portugal", description: "")
        let original = Country(name: "Portugal", cities: [city], continentsVisited: ["Europe"])

        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Country.self, from: data)

        XCTAssertEqual(decoded.name, "Portugal")
        XCTAssertEqual(decoded.cities.count, 1)
        XCTAssertEqual(decoded.cities[0].name, "Lisbon")
        XCTAssertEqual(decoded.continentsVisited, ["Europe"])
    }
    
    func testCityCodableRoundTrip() throws {
        let original = City(name: "Lisbon", country: "Portugal", description: "Capital", imageData: Data([0x01, 0x02]))

        let data = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(City.self, from: data)

        XCTAssertEqual(decoded.name, original.name)
        XCTAssertEqual(decoded.country, original.country)
        XCTAssertEqual(decoded.description, original.description)
        XCTAssertEqual(decoded.imageData, original.imageData)
    }
    
    func testAddCityPerformance() {
        let model = VisitedCountriesModel()
        let country = Country(name: "Portugal", cities: [])
        let city = City(name: "Lisbon", country: "Portugal", description: "")

        measure {
            model.addCity(city, to: country)
        }
    }
    
    func testAddMultipleCitiesPerformance() {
        let model = VisitedCountriesModel()
        let country = Country(name: "Portugal", cities: [])

        measure {
            for i in 0..<1000 {
                let city = City(name: "City \(i)", country: "Portugal", description: "")
                model.addCity(city, to: country)
            }
        }
    }
    
    func testCityCodablePerformance() {
        let city = City(name: "Lisbon", country: "Portugal", description: "Capital")

        measure {
            let data = try? JSONEncoder().encode(city)
            _ = try? JSONDecoder().decode(City.self, from: data ?? Data())
        }
    }
}
