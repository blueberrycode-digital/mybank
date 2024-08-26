//
//  MyBankUITests.swift
//  MyBankUITests
//
//  Created by DM (Personal) on 30/05/2024.
//

import XCTest

final class MyBankUITests: XCTestCase {

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let openAppButton = app.buttons["Open app"]
        
        XCTAssertTrue(openAppButton.waitForExistence(timeout: 1))
        openAppButton.tap()
        
        let section1Button = app.buttons["Between your own accounts"]
        
        XCTAssertTrue(section1Button.waitForExistence(timeout: 1))
        section1Button.tap()
        
        // And so on
    }

}
