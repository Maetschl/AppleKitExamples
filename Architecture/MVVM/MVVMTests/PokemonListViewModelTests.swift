//
//  PokemonListViewModelTests.swift
//  MVVMTests
//
//  Created by Julian Arias Maetschl on 11-01-21.
//

import XCTest
@testable import MVVM

class PokemonListViewModelTests: XCTestCase {

    // MARK: Subject under test
    var sut: PokemonListViewModel!

    override func setUpWithError() throws {
        sut = PokemonListViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testClearFilter() throws {
        // Given
        // When
        sut.clearFilter()
        // Then
        XCTAssertEqual(sut.selectedFilter, .none)
    }

    func testFireFilter() throws {
        // Given
        // When
        sut.filterBy(.fire)
        // Then
        XCTAssertEqual(sut.selectedFilter, .fire)
        XCTAssertTrue(sut.pokemons.allSatisfy({ $0.type == .fire }))
    }

}
