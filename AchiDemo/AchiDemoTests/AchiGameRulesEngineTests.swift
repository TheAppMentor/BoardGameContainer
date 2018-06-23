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
    
    func testGetAllPossibleMovesForPlayer_NOT_ALL_COINS_PLACED(){
        
        let gameBoard = TestUtils.createSimpleAchiGameBoard()

        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 2, col: 2, occupiedBy: gameBoard.blackPlayer))

        let allGameModelUpdates = gameBoard.gameModelUpdates(for: gameBoard.redPlayer) as! [AchiMove]
        
        XCTAssertTrue(allGameModelUpdates.count == 5)
        
        XCTAssertTrue(self.hasGameMove(gameMovesArr: allGameModelUpdates, refMove: AchiMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer)), "Did not match. \(allGameModelUpdates) \n\nexpected \(GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer))")

        XCTAssertTrue(self.hasGameMove(gameMovesArr: allGameModelUpdates, refMove: AchiMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer)), "Did not match. \(allGameModelUpdates) \n\nexpected \(GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer))")

        XCTAssertTrue(self.hasGameMove(gameMovesArr: allGameModelUpdates, refMove: AchiMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer)), "Did not match. \(allGameModelUpdates) \n\nexpected \(GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer))")

        XCTAssertTrue(self.hasGameMove(gameMovesArr: allGameModelUpdates, refMove: AchiMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer)), "Did not match. \(allGameModelUpdates) \n\nexpected \(GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer))")

        XCTAssertTrue(self.hasGameMove(gameMovesArr: allGameModelUpdates, refMove: AchiMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer)), "Did not match. \(allGameModelUpdates) \n\nexpected \(GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: nil), player: gameBoard.redPlayer))")
    }

    
    func testGetAllPossibleMovesForPlayer_ALL_COINS_PLACED_MOVE_FROM_CORNER_BLACK_MOVES(){
        
        let gameBoard = TestUtils.createSimpleAchiGameBoard()
        /*
            B - B - R
            B - B - R
            R - R - 0
         */

        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 1, occupiedBy: gameBoard.blackPlayer))
        
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 2, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 2, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 2, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 2, col: 1, occupiedBy: gameBoard.redPlayer))

        let allGameModelUpdates = gameBoard.gameModelUpdates(for: gameBoard.blackPlayer) as! [AchiMove]
        
        XCTAssertTrue(allGameModelUpdates.count == 1,"Should be 1.. it is -> \(allGameModelUpdates.count)")
        
        XCTAssertTrue(self.hasGameMove(gameMovesArr: allGameModelUpdates,
                                       refMove: GameMove(startPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: gameBoard.blackPlayer), endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: nil), player: gameBoard.blackPlayer)))
    }
    
    
    func testGetAllPossibleMovesForPlayer_ALL_COINS_PLACED_MOVE_FROM_CORNER_RED_MOVES(){
        
        /*
         B - B - R
         B - B - R
         R - R - 0
         */
        let gameBoard = TestUtils.createSimpleAchiGameBoard()
        
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 0, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 1, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 0, occupiedBy: gameBoard.blackPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 1, occupiedBy: gameBoard.blackPlayer))

        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 0, col: 2, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 1, col: 2, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 2, col: 0, occupiedBy: gameBoard.redPlayer))
        try? gameBoard.updatePosition(position: AchiBoardPosition.init(row: 2, col: 1, occupiedBy: gameBoard.redPlayer))

        let allGameModelUpdates = gameBoard.gameModelUpdates(for: gameBoard.redPlayer) as! [AchiMove]
        
        XCTAssertTrue(allGameModelUpdates.count == 2,"Should be 2.. it is -> \(allGameModelUpdates.count)")

        XCTAssertTrue(self.hasGameMove(gameMovesArr: allGameModelUpdates,
                                       refMove: GameMove(startPos: AchiBoardPosition(row: 2, col: 1, occupiedBy: gameBoard.redPlayer), endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: gameBoard.redPlayer), player: gameBoard.redPlayer)))

        XCTAssertTrue(self.hasGameMove(gameMovesArr: allGameModelUpdates,
                                       refMove: GameMove(startPos: AchiBoardPosition(row: 1, col: 2, occupiedBy: gameBoard.redPlayer), endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: gameBoard.redPlayer), player: gameBoard.redPlayer)))
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
    
    // Helper Functions :
    func hasGameMove(gameMovesArr : [GameMove], refMove : GameMove) -> Bool{
        
        // The Game MOve inherits form GKGameModelUpdate, for some reason, I am not able to override the == method in GameMove.
        // Need to write this crap logic below to get over this limitation.
        for eachMove in gameMovesArr{
            if (eachMove.startPos?.row == refMove.startPos?.row && eachMove.startPos?.col == refMove.startPos?.col && eachMove.endPos.row == refMove.endPos.row && eachMove.endPos.col == refMove.endPos.col && eachMove.player.playerId == refMove.player.playerId) == true {
                return true
            }
            continue
        }
        return false
    }
    
}
