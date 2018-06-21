//
//  TestUtils.swift
//  AchiDemoTests
//
//  Created by Moorthy, Prashanth on 20/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

class TestUtils{
    
    static func createSimpleAchiGameBoard() -> AchiGameBoard {
        let redPlayer = AchiPlayer(color: .Red)
        let blackPlayer = AchiPlayer(color: .Black)
        
        let achiGameBoard = GameBoardFactory.createGameBoard(gameType: .AchiGame, players: [redPlayer, blackPlayer])
        return achiGameBoard as! AchiGameBoard
    }
}

