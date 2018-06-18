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
    
    func createSimpleGameBoard() -> GameBoard? {
        let redPlayer = AchiPlayer()
        let blackPlayer = AchiPlayer()
        
        let achiGameBoard = GameBoardFactory.createGameBoard(gameType: .AchiGame, players: [redPlayer, blackPlayer])

        return achiGameBoard
    }
    
    func testSubscriptSetPosition(){

        let achiGameBoard = createSimpleGameBoard()
        
        let gamePos = AchiBoardPosition(row : 0, col : 0, occupiedBy : nil)
        let gamePlayer = (achiGameBoard?.currentlyActivePlayer)!
        let gameMove = GameMove.init(startPosition: nil, endPostion: gamePos, player: gamePlayer)
        let moveResult = achiGameBoard?.make(move: gameMove)
        XCTAssertTrue(moveResult!, "Game Move Failed ....")
        
        let row : UInt8 = 0
        let col : UInt8 = 0
        
        XCTAssertNotNil((achiGameBoard as! AchiGameBoard)[row,col])
        
        let updatedPosition = (achiGameBoard as! AchiGameBoard)[row,col]
        XCTAssert(updatedPosition != nil, "Updated Position failed")
    }
    
    func testSubscriptGetPosition(){
        if let achiGameBoard = createSimpleGameBoard() as? AchiGameBoard{
            achiGameBoard[0,1] = AchiBoardPosition.init(row: 0, col: 1, occupiedBy: achiGameBoard.players?.first as? GamePlayer)
            
            let fetchedPos = achiGameBoard[0,1]
            XCTAssertTrue(((fetchedPos?.occupiedBy)! as! AchiPlayer) == (achiGameBoard.players?.first as! AchiPlayer), "Getting subscript by position failed.")
            XCTAssertTrue(fetchedPos?.row == 0,  "Getting subscript by position failed.")
            XCTAssertTrue(fetchedPos?.col == 1,  "Getting subscript by position failed.")
        }else{
            XCTFail()
        }
        
    }
}
