//
//  MyMapTest.swift
//  MyMapUITests
//
//  Created by stud on 26/01/2026.
//

import XCTest

final class MyMapTest: XCTestCase {

    func testLoginScreenHasEmailPasswordAndButton() {
        let app = XCUIApplication()
        app.launchArguments += ["-resetLogin"]
        app.launch()

        let loginScreen = app.otherElements["LoginScreen"]
        XCTAssertTrue(loginScreen.waitForExistence(timeout: 5))

        XCTAssertTrue(app.textFields["emailField"].exists, "Campo de email devia existir")
        XCTAssertTrue(app.secureTextFields["passwordField"].exists, "Campo de password devia existir")
        XCTAssertTrue(app.buttons["loginButton"].exists, "Botão de login devia existir")
    }
    
    func testHomeTabButtonExistsAndCanBeTapped() {
        let app = XCUIApplication()
        app.launch()

        let homeTab = app.buttons["Home"]
        XCTAssertTrue(homeTab.waitForExistence(timeout: 5))

        homeTab.tap()
        XCTAssertTrue(app.state == .runningForeground)
    }
    
    func testAddTabButtonExistsAndCanBeTapped() {
        let app = XCUIApplication()
        app.launch()

        let addTab = app.buttons["Add"]
        XCTAssertTrue(addTab.waitForExistence(timeout: 5))

        addTab.tap()
        XCTAssertTrue(app.state == .runningForeground)
    }
    
    func testProfileTabButtonExistsAndCanBeTapped() {
        let app = XCUIApplication()
        app.launch()

        let profileTab = app.buttons["Profile"]
        XCTAssertTrue(profileTab.waitForExistence(timeout: 5))

        profileTab.tap()
        XCTAssertTrue(app.state == .runningForeground)
    }
}
