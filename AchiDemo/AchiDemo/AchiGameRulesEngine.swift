//
//  AchiGameRulesEngine.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

public class AchiGameRulesEngine : GameRulesEngine {
    
    public init() {
    }
    
    public func getAllPossibleMovesForPlayer(gameBoard: GameBoard, gamePlayer: GamePlayer) -> [GameMove] {
        
        var allPossibleMoves = [[GameMove]]()
        
        // If a player has not placed all his coins on the table. Possibles moves must only include moves to place a coin in any open position on the board.
        let allPositionsForPlayer = gameBoard.getAllPositionsForPlayer(player: gamePlayer)
        
        if allPositionsForPlayer.count < gameBoard.coinCountPerPlayer{
            let allOpenPositions = gameBoard.getAllOpenPositions()
            return allOpenPositions.map({ (eachPos) -> GameMove in
                return GameMove(startPosition: nil, endPostion: eachPos, player: gamePlayer)
            })
        }
        
        allPossibleMoves = allPositionsForPlayer.map { (gamePosition) -> [GameMove] in
            
            let openPositions = gamePosition.adjacentOpenPositions(gameBoard: gameBoard)
            
            var allMovesForPosition = [GameMove]()
            
            for eachOpenPosition in openPositions{
                let tempMove = GameMove(startPosition: eachOpenPosition, endPostion: eachOpenPosition, player: gamePlayer)
                allMovesForPosition.append(tempMove)
            }
            
            return allMovesForPosition
        }
        
        return Array(allPossibleMoves.joined())
    }
    
    public func isValidMove(gameBoard: GameBoard, gameMove: GameMove) -> Bool {
        
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
