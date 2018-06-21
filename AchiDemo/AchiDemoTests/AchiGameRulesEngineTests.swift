//
//  AchiGameRulesEngineTests.swift
//  AchiDemoTests
//
//  Created by Moorthy, Prashanth on 16/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import XCTest

class AchiGameRulesEngineTests: XCTestCase {

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
    
    func testGetAllPossibleMovesForPlayer(){
        
        let gameBoard = TestUtils.createSimpleAchiGameBoard()

        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 2, col: 2, occupiedBy: gameBoard.blackPlayer))

        let allGameModelUpdates = gameBoard.gameModelUpdates(for: gameBoard.redPlayer)
        
        print(allGameModelUpdates)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func testPlaceCoinOnOpenBoard(){
        //let gameBoard = GameBoardFactory.createGameBoard(gameType : .AchiGame)
    }
    
    func testMoveToValidPosition(){
        
    }
    
    func testMoveToInvalidPosition(){
        
    }
    
    
    
    
    func testGetPossibleMakeValidMove(){
        //let achiGameBoard = GameBoardFactory.createGameBoard(gameType: .AchiGame)        
    }
    
    

}
