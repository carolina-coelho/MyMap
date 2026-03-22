//
//  MyMapUITests.swift
//  MyMapUITests
//
//  Created by stud on 19/01/2026.
//

import XCTest

final class MyMapUITests: XCTestCase {

    func testCanTypeEmailAndPassword() {
        let app = XCUIApplication()
        app.launchArguments += ["-resetLogin"]
        app.launch()

        XCTAssertTrue(app.otherElements["LoginScreen"].waitForExistence(timeout: 5))

        let emailField = app.textFields["emailField"]
        emailField.tap()
        emailField.typeText("teste@mail.com")

        let passField = app.secureTextFields["passwordField"]
        passField.tap()
        passField.typeText("123456")

        XCTAssertTrue(emailField.value as? String == "teste@mail.com")
    }
    
    func testTappingLoginButtonDoesNotCrash() {
        let app = XCUIApplication()
        app.launchArguments += ["-resetLogin"]
        app.launch()

        XCTAssertTrue(app.otherElements["LoginScreen"].waitForExistence(timeout: 5))

        let loginButton = app.buttons["loginButton"]
        XCTAssertTrue(loginButton.exists)

        loginButton.tap()

        XCTAssertTrue(app.state == .runningForeground)
    }

    @MainActor
    func testAppLaunchesSuccessfully() {
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.state == .runningForeground, "A app devia estar a correr em foreground")
    }
}
