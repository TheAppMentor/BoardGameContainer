//
//  AchiGameBoardFactoryTests.swift
//  AchiDemoTests
//
//  Created by Moorthy, Prashanth on 17/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import XCTest

class GameBoardFactoryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreateGameBoardForAchiCheckCounts(){
        let achiGameBoard = GameBoardFactory.createGameBoard(gameType: .AchiGame, players: [])
        XCTAssertTrue(achiGameBoard?.getAllPositions().count == 9, "Incorrect Game Board Count")
    }
}
