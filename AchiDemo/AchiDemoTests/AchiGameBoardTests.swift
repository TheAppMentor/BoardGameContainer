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
        let achiGameBoard = TestUtils.createSimpleAchiGameBoard()
        achiGameBoard[0,1] = AchiBoardPosition.init(row: 0, col: 1, occupiedBy: achiGameBoard.players?.first as? GamePlayer)
        
        let fetchedPos = achiGameBoard[0,1]
        XCTAssertTrue(((fetchedPos?.occupiedBy)! as! AchiPlayer) == (achiGameBoard.players?.first as! AchiPlayer), "Getting subscript by position failed.")
        XCTAssertTrue(fetchedPos?.row == 0,  "Getting subscript by position failed.")
        XCTAssertTrue(fetchedPos?.col == 1,  "Getting subscript by position failed.")
    }
    
    func testConsecutivePositions(){
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        let consQPositions = achiBoard.consecutivePositions
        
        XCTAssertTrue(consQPositions.count == 8, "Invalid Consequtive Positions.")
        
        XCTAssertTrue(consQPositions[0][0] as! AchiBoardPosition == AchiBoardPosition(row: 0, col: 0, occupiedBy: nil))
        XCTAssertTrue(consQPositions[0][1] as! AchiBoardPosition == AchiBoardPosition(row: 0, col: 1, occupiedBy: nil))
        XCTAssertTrue(consQPositions[0][2] as! AchiBoardPosition == AchiBoardPosition(row: 0, col: 2, occupiedBy: nil))
        
        XCTAssertTrue(consQPositions[1][0] as! AchiBoardPosition == AchiBoardPosition(row: 1, col: 0, occupiedBy: nil))
        XCTAssertTrue(consQPositions[1][1] as! AchiBoardPosition == AchiBoardPosition(row: 1, col: 1, occupiedBy: nil))
        XCTAssertTrue(consQPositions[1][2] as! AchiBoardPosition == AchiBoardPosition(row: 1, col: 2, occupiedBy: nil))
        
        XCTAssertTrue(consQPositions[2][0] as! AchiBoardPosition == AchiBoardPosition(row: 2, col: 0, occupiedBy: nil))
        XCTAssertTrue(consQPositions[2][1] as! AchiBoardPosition == AchiBoardPosition(row: 2, col: 1, occupiedBy: nil))
        XCTAssertTrue(consQPositions[2][2] as! AchiBoardPosition == AchiBoardPosition(row: 2, col: 2, occupiedBy: nil))
        
        XCTAssertTrue(consQPositions[0][0] as! AchiBoardPosition == AchiBoardPosition(row: 0, col: 0, occupiedBy: nil))
        XCTAssertTrue(consQPositions[1][0] as! AchiBoardPosition == AchiBoardPosition(row: 1, col: 0, occupiedBy: nil))
        XCTAssertTrue(consQPositions[2][0] as! AchiBoardPosition == AchiBoardPosition(row: 2, col: 0, occupiedBy: nil))
        
        XCTAssertTrue(consQPositions[0][1] as! AchiBoardPosition == AchiBoardPosition(row: 0, col: 1, occupiedBy: nil))
        XCTAssertTrue(consQPositions[1][1] as! AchiBoardPosition == AchiBoardPosition(row: 1, col: 1, occupiedBy: nil))
        XCTAssertTrue(consQPositions[2][1] as! AchiBoardPosition == AchiBoardPosition(row: 2, col: 1, occupiedBy: nil))
        
        XCTAssertTrue(consQPositions[0][2] as! AchiBoardPosition == AchiBoardPosition(row: 0, col: 2, occupiedBy: nil))
        XCTAssertTrue(consQPositions[1][2] as! AchiBoardPosition == AchiBoardPosition(row: 1, col: 2, occupiedBy: nil))
        XCTAssertTrue(consQPositions[2][2] as! AchiBoardPosition == AchiBoardPosition(row: 2, col: 2, occupiedBy: nil))
        
        XCTAssertTrue(consQPositions[0][0] as! AchiBoardPosition == AchiBoardPosition(row: 0, col: 0, occupiedBy: nil))
        XCTAssertTrue(consQPositions[1][1] as! AchiBoardPosition == AchiBoardPosition(row: 1, col: 1, occupiedBy: nil))
        XCTAssertTrue(consQPositions[2][2] as! AchiBoardPosition == AchiBoardPosition(row: 2, col: 2, occupiedBy: nil))
        
        XCTAssertTrue(consQPositions[0][2] as! AchiBoardPosition == AchiBoardPosition(row: 0, col: 2, occupiedBy: nil))
        XCTAssertTrue(consQPositions[1][1] as! AchiBoardPosition == AchiBoardPosition(row: 1, col: 1, occupiedBy: nil))
        XCTAssertTrue(consQPositions[2][0] as! AchiBoardPosition == AchiBoardPosition(row: 2, col: 0, occupiedBy: nil))
    }
    
    func testMakeMove_INITIAL_MOVE_FIRST_COIN_PLACEMENT_BLACK(){
        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.blackPlayer
        let validMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        
        let checkPos = achiBoard[0,0] as! AchiBoardPosition
        
        XCTAssertTrue(checkPos == AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 1 , "Incorrect Position count for Black player")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 0 , "Incorrect Position count for Red player")
    }
    
    func testMakeMove_INITIAL_MOVE_FIRST_COIN_PLACEMENT_RED(){
        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.redPlayer
        let validMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        
        let checkPos = achiBoard[0,0] as! AchiBoardPosition
        
        XCTAssertTrue(checkPos == AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 1 , "Incorrect Position count for redPlayer player")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 0 , "Incorrect Position count for Black player")
    }
    
    func testMakeMove_INITIAL_MOVE_SECOND_COIN_PLACEMENT_BLACK(){
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.blackPlayer
        
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        //achiBoard.currentlyActivePlayer = achiBoard.redPlayer
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        
        let validMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let inValidMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        XCTAssertTrue(inValidMove == false, "Invalid Game Move")
        
        let checkPosOldBlack = achiBoard[0,0] as! AchiBoardPosition
        let checkPosOldRed = achiBoard[1,0] as! AchiBoardPosition
        let checkPosNowMoved = achiBoard[0,1] as! AchiBoardPosition
        
        XCTAssertTrue(checkPosOldBlack == AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosNowMoved == AchiBoardPosition(row: 0, col: 1, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldRed == AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 2 , "Incorrect Position count for Black player")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 1 , "Incorrect Position count for red player")
    }
    
    func testMakeMove_INITIAL_MOVE_SECOND_COIN_PLACEMENT_RED(){
        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.blackPlayer
        
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        let validMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let inValidMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        XCTAssertTrue(inValidMove == false, "Invalid Game Move")
        
        let checkPosOldBlack1 = achiBoard[0,0] as! AchiBoardPosition
        let checkPosOldBlack2 = achiBoard[1,1] as! AchiBoardPosition
        let checkPosOldRed = achiBoard[2,2] as! AchiBoardPosition
        let checkPosNowMoved = achiBoard[1,0] as! AchiBoardPosition
        
        XCTAssertTrue(checkPosOldBlack1 == AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldBlack2 == AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldRed == AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosNowMoved == AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 2 , "Incorrect Position count for Black player")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 2 , "Incorrect Position count for red player")
        
    }
    
    func testMakeMove_INITIAL_MOVE_THIRD_COIN_PLACEMENT_BLACK(){
        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.blackPlayer
        
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        
        let validMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let inValidMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        XCTAssertTrue(inValidMove == false, "Invalid Game Move")
        
        let checkPosOldBlack1 = achiBoard[0,0] as! AchiBoardPosition
        let checkPosOldBlack2 = achiBoard[1,1] as! AchiBoardPosition
        let checkPosOldRed1 = achiBoard[2,2] as! AchiBoardPosition
        let checkPosOldRed2 = achiBoard[1,0] as! AchiBoardPosition
        let checkPosNowMoved = achiBoard[2,0] as! AchiBoardPosition
        
        XCTAssertTrue(checkPosOldBlack1 == AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldBlack2 == AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldRed1 == AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldRed2 == AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosNowMoved == AchiBoardPosition(row: 2, col: 0, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 3 , "Incorrect Position count for Black player")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 2 , "Incorrect Position count for red player")
    }
    
    //TODO : Too bored to write the case for placing 4th coin, things seem fine. Moving on.
    
    func testMakeMove_INITIAL_MOVE_THIRD_COIN_PLACEMENT_RED(){
        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.blackPlayer
        
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        let validMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 1, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let inValidMove = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        XCTAssertTrue(inValidMove == false, "Invalid Game Move")
        
        let checkPosOldBlack1 = achiBoard[0,0] as! AchiBoardPosition
        let checkPosOldBlack2 = achiBoard[1,1] as! AchiBoardPosition
        let checkPosOldBlack3 = achiBoard[2,0] as! AchiBoardPosition
        
        let checkPosOldRed1 = achiBoard[2,2] as! AchiBoardPosition
        let checkPosOldRed2 = achiBoard[1,0] as! AchiBoardPosition
        let checkPosNowMoved = achiBoard[2,1] as! AchiBoardPosition
        
        XCTAssertTrue(checkPosOldBlack1 == AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldBlack2 == AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldBlack3 == AchiBoardPosition(row: 2, col: 0, occupiedBy: achiBoard.blackPlayer), "Incorrect Initial Move")
        
        XCTAssertTrue(checkPosOldRed1 == AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosOldRed2 == AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        XCTAssertTrue(checkPosNowMoved == AchiBoardPosition(row: 2, col: 1, occupiedBy: achiBoard.redPlayer), "Incorrect Initial Move")
        
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 3 , "Incorrect Position count for Black player")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 3 , "Incorrect Position count for red player")
    }
    
    func testMakeMove_ALL_PLACED_SIMPLE_MOVE_BLACK(){
        
        /*      B - B - R
         B - B - R
         R - R - 0         */
        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.blackPlayer
        
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 1, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        
        let totalMovesForBlack = achiBoard.gameRulesEngine.getAllPossibleMovesForPlayer(gameBoard: achiBoard, gamePlayer: achiBoard.blackPlayer).count
        let validMove = achiBoard.make(move: GameMove(startPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let inValidMove = achiBoard.make(move: GameMove(startPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        XCTAssertTrue(inValidMove == false, "Invalid Game Move")
        XCTAssertTrue(totalMovesForBlack == 1, "Invalid Possible Moves for Black.")
        
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 4 , "Incorrect Position count Black Expected 4 , was \(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count)")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 4 , "Incorrect Position count for red player")
    }
    
    func testMakeMove_ALL_PLACED_SIMPLE_MOVE_RED(){
        /*      B - B - R
         B - 0 - R
         R - R - B         */
        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.blackPlayer
        
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 1, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        let totalMovesForRed = achiBoard.gameRulesEngine.getAllPossibleMovesForPlayer(gameBoard: achiBoard, gamePlayer: achiBoard.redPlayer).count
        let validMove = achiBoard.make(move: GameMove(startPos: AchiBoardPosition(row: 1, col: 2, occupiedBy: achiBoard.blackPlayer), endPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let inValidMove = achiBoard.make(move: GameMove(startPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: achiBoard.blackPlayer), endPos: AchiBoardPosition(row: 1, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        
        
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        XCTAssertTrue(inValidMove == false, "Invalid Game Move")
        XCTAssertTrue(totalMovesForRed == 4, "Invalid Possible Moves for Black.")
        
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count == 4 , "Incorrect Position count Black Expected 4 , was \(achiBoard.getAllPositionsForPlayer(player: achiBoard.blackPlayer).count)")
        XCTAssertTrue(achiBoard.getAllPositionsForPlayer(player: achiBoard.redPlayer).count == 4 , "Incorrect Position count for red player")
        
    }
    
    func testMakeMove_ALL_PLACED_MOVE_FOR_WIN_BLACK(){
        /*      B - B - R
                B - 0 - R
                R - R - B         */

        
        /*      B - B - R
                B - X - X
                R - R - B         */

        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.blackPlayer
        
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 1, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))

        let validMove = achiBoard.make(move: GameMove(startPos: AchiBoardPosition(row: 0, col: 1, occupiedBy: achiBoard.blackPlayer), endPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        
        let boardState = achiBoard.evaluateBoardState()
        
        print("Board State is \(boardState)")
        switch boardState {
        case .GameOverIsWinForPlayer:
            XCTAssertTrue(true, "\(boardState)")
        default:
            print("Talking from Default : \(boardState)")
            XCTFail()
        }

    }
    
    func testMakeMove_ALL_PLACED_MOVE_FOR_WIN_RED(){

        /*      B - B - R
                B - B - R
                R - R - 0         */

        /*      B - B - R
                B - B - R
                R - 0 - R         */

        
        let achiBoard = TestUtils.createSimpleAchiGameBoard()
        achiBoard.currentlyActivePlayer = achiBoard.redPlayer
        
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 1, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 0, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 2, col: 0, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 0, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
        let _ = achiBoard.make(move: GameMove(startPos: nil, endPos: AchiBoardPosition(row: 1, col: 1, occupiedBy: achiBoard.blackPlayer), player: achiBoard.blackPlayer))
        
        let validMove = achiBoard.make(move: GameMove(startPos: AchiBoardPosition(row: 2, col: 1, occupiedBy: achiBoard.redPlayer), endPos: AchiBoardPosition(row: 2, col: 2, occupiedBy: achiBoard.redPlayer), player: achiBoard.redPlayer))
       
        XCTAssertTrue(validMove == true, "Invalid Game Move")
        
        let boardState = achiBoard.evaluateBoardState()

        print("Board State is \(boardState)")
        switch boardState {
        case .GameOverIsWinForPlayer:
            XCTAssertTrue(true, "\(boardState)")
        default:
            print("Talking from Default : \(boardState)")
            XCTFail()
        }
    }
}
