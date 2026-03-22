//
//  MyMapUITestsLaunchTests.swift
//  MyMapUITests
//
//  Created by stud on 19/01/2026.
//

import XCTest

final class MyMapUITestsLaunchTests: XCTestCase {

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    @MainActor
    func testAppLaunchPerformance() {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
