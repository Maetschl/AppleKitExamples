//
//  MVVMUITests.swift
//  MVVMUITests
//
//  Created by Julian Arias Maetschl on 11-01-21.
//

import XCTest

class MVVMUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAllPokemon3Views() throws {

        let app = XCUIApplication()
        app.launch()


        let button = app.buttons["All Pokemons"]
        button.tap()

        XCTAssertEqual(app.staticTexts.count, 3)

    }

    func testFirePokemon1Views() throws {

        let app = XCUIApplication()
        app.launch()


        let button = app.buttons["Fire type"]
        button.tap()

        XCTAssertEqual(app.staticTexts.count, 1)

    }

}
