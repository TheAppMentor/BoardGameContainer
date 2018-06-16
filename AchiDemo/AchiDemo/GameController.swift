//
//  GameController.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

class GameController {
    var gameBoard : GameBoard
        
    init?(gameType : GameType) {
        self.gameBoard = GameBoardFactory.createGameBoard(gameType: gameType)!
    }
}
