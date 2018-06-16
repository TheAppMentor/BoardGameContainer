//
//  AchiGameRulesEngine.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

class AchiGameRulesEngine : GameRulesEngine {
    
    func getAllPossibleMovesForPlayer(gameBoard: GameBoard, gamePlayer: GamePlayer) -> [GameMove] {
        return []
    }
    
    func isValidMove(gameBoard: GameBoard, gameMove: GameMove) -> Bool {
        return false
    }
}
