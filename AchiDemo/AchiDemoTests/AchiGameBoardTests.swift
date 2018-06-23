//
//  AchiGameBoardTests.swift
//  AchiDemoTests
//
//  Created by Moorthy, Prashanth on 4/22/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

import XCTest

class AchiGameBoardTests: XCTestCase {
    
    func testSubscriptSetPosition(){

        let achiGameBoard = TestUtils.createSimpleAchiGameBoard()
        
        let gamePos = AchiBoardPosition(row : 0, col : 0, occupiedBy : nil)
        let gamePlayer = (achiGameBoard.currentlyActivePlayer)
        let gameMove = GameMove.init(startPos: nil, endPos: gamePos, player: gamePlayer)
        let moveResult = achiGameBoard.make(move: gameMove)
        XCTAssertTrue(moveResult, "Game Move Failed ....")
        
        let row : UInt8 = 0
        let col : UInt8 = 0
        
        XCTAssertNotNil((achiGameBoard)[row,col])
        
        let updatedPosition = achiGameBoard[row,col]
        XCTAssert(updatedPosition != nil, "Updated Position failed")
    }
    
    func testSubscriptGetPosition(){
        if let achiGameBoard = TestUtils.createSimpleAchiGameBoard() as? AchiGameBoard{
            achiGameBoard[0,1] = AchiBoardPosition.init(row: 0, col: 1, occupiedBy: achiGameBoard.players?.first as? GamePlayer)
            
            let fetchedPos = achiGameBoard[0,1]
            XCTAssertTrue(((fetchedPos?.occupiedBy)! as! AchiPlayer) == (achiGameBoard.players?.first as! AchiPlayer), "Getting subscript by position failed.")
            XCTAssertTrue(fetchedPos?.row == 0,  "Getting subscript by position failed.")
            XCTAssertTrue(fetchedPos?.col == 1,  "Getting subscript by position failed.")
        }else{
            XCTFail()
        }
    }
    
    func testMakeMove_INITIAL_MOVE_FIRST_COIN_PLACEMENT_BLACK(){
        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        //achiBoard.activePlayer = achiBoard.blackPlayer
        let validMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        
        let checkPos = achiBoard[0,0] as! AchiBoardPosition
        
        XCTAssertTrue(checkPos == AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 1 , "Incorrect Position count for Black player")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 0 , "Incorrect Position count for Red player")
    }

    func testMakeMove_INITIAL_MOVE_FIRST_COIN_PLACEMENT_RED(){

        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        //achiBoard.activePlayer = achiBoard.redPlayer
        let validMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        
        let checkPos = achiBoard[0,0] as! AchiBoardPosition
        
        XCTAssertTrue(checkPos == AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 1 , "Incorrect Position count for redPlayer player")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 0 , "Incorrect Position count for Black player")
    }
    
    func testMakeMove_INITIAL_MOVE_SECOND_COIN_PLACEMENT_BLACK(){
        
    }

    func testMakeMove_INITIAL_MOVE_SECOND_COIN_PLACEMENT_RED(){
        
    }
    
    func testMakeMove_INITIAL_MOVE_THIRD_COIN_PLACEMENT_BLACK(){
        
    }

    func testMakeMove_INITIAL_MOVE_THIRD_COIN_PLACEMENT_RED(){
        
    }
    
    func testMakeMove_ALL_PLACED_SIMPLE_MOVE_BLACK(){
        
    }

    func testMakeMove_ALL_PLACED_SIMPLE_MOVE_RED(){
        
    }

    func testMakeMove_ALL_PLACED_MOVE_FOR_WIN_BLACK(){
        
    }

    func testMakeMove_ALL_PLACED_MOVE_FOR_WIN_RED(){
        
    }

}
