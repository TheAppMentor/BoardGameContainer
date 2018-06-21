//
//  AchiBoardPositionTests.swift
//  AchiDemoTests
//
//  Created by Moorthy, Prashanth on 20/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import XCTest

class AchiBoardPositionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAdjPosition_R0_C0(){
        let gameBoard = TestUtils.createSimpleAchiGameBoard()
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.redPlayer))

        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer))
//        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 0, occupiedBy: nil))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.redPlayer))

        let postions_R0_C0 = gameBoard[0,0]
        let adjPositions = postions_R0_C0?.adjacentPositions(gameBoard: gameBoard)
        XCTAssertTrue(adjPositions?.count == 3, "Incorrect Adj Positions Count == \(String(describing: adjPositions?.count)), should be 3 !!!")
        
        //TODO: More stuff needs to be checked here..
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.redPlayer)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 1, col: 1, occupiedBy: nil)), "Incorrect Board Position")
    }

    func testGetAdjPosition_R1_C1(){
        let gameBoard = TestUtils.createSimpleAchiGameBoard()
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 2, col: 2, occupiedBy: gameBoard.blackPlayer))

        let postions_R0_C0 = gameBoard[1,1]
        let adjPositions = postions_R0_C0?.adjacentPositions(gameBoard: gameBoard)
        XCTAssertTrue(adjPositions?.count == 8, "Incorrect Adj Positions Count == \(String(describing: adjPositions?.count)), should be 8 !!!")
        
        //TODO: More stuff needs to be checked here..
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.redPlayer)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 0, col: 2, occupiedBy: nil)), "Incorrect Board Position")

        
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.redPlayer)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 1, col: 2, occupiedBy: nil)), "Incorrect Board Position")

        
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 2, col: 0, occupiedBy: nil)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 2, col: 1, occupiedBy: nil)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 2, col: 2, occupiedBy: gameBoard.blackPlayer)), "Incorrect Board Position")

        XCTAssertFalse((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 1, col: 1, occupiedBy: nil)), "Incorrect Board Position")
    }

    
    func testGetAllPosition_R1_C1(){
        let gameBoard = TestUtils.createSimpleAchiGameBoard()
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 2, col: 2, occupiedBy: gameBoard.blackPlayer))
        
        let postions_R0_C0 = gameBoard[1,1]
        let adjPositions = postions_R0_C0?.adjacentAllPositionsAround(gameBoard: gameBoard)
        XCTAssertTrue(adjPositions?.count == 9, "Incorrect Adj Positions Count == \(String(describing: adjPositions?.count)), should be 9 !!!")
        
        //TODO: More stuff needs to be checked here..
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.redPlayer)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 0, col: 2, occupiedBy: nil)), "Incorrect Board Position")
        
        
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.redPlayer)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 1, col: 2, occupiedBy: nil)), "Incorrect Board Position")
        
        
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 2, col: 0, occupiedBy: nil)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 2, col: 1, occupiedBy: nil)), "Incorrect Board Position")
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 2, col: 2, occupiedBy: gameBoard.blackPlayer)), "Incorrect Board Position")
        
        XCTAssertTrue((adjPositions as! [AchiBoardPosition]).contains(AchiBoardPosition.init(row: 1, col: 1, occupiedBy: nil)), "Incorrect Board Position")
    }
}
