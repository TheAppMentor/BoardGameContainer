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
        
        // The From and To Positions should be valid Board Positions.
        
        // From Position should be occupied by the player making the move. i.e he can only move his coins,
        guard (gameMove.player as! AchiPlayer) == (gameBoard.activePlayer as! AchiPlayer) else {
            return false
        }
        
        // From position should be populated, only if he has first placed all the coins on the board.
        // i.e if he has only placed say 1 coin on the board, he cant move till he places all the coins.
        let numPostionForPlayer = gameBoard.getAllPositionsForPlayer(player: gameMove.player).count
        
        // If all coins were already placed on the board, (initial loading of the board).
        // From positions should not be nil.
        if numPostionForPlayer == (gameBoard as! AchiGameBoard).coinCountPerPlayer {
            guard gameMove.startPosition != nil else {
                return false
            }
        }
        
        // To Position should not be occupied.
        guard let _ = try? gameBoard.isOccupied(gamePos: gameMove.endPostion) == false else {
            return false
        }
        
        return true
    }
}
