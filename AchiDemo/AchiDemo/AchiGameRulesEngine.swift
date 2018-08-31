//
//  AchiGameRulesEngine.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import UIKit


public class AchiGameRulesEngine : GameRulesEngine {
    
    public func evaluateBoardState(gameBoard: GameBoard) -> GameState {
        
        switch checkBoardStateForDraw(gameBoard: gameBoard) {
        case .GameOverDraw:
            return GameState.GameOverDraw
        default:
            break
        }
        
        return checkBoardStateForWin(gameBoard: gameBoard)
    }
    
    private func checkBoardStateForWin(gameBoard : GameBoard) -> GameState{
        
        if let gameBoard = gameBoard as? AchiGameBoard {
            
            for eachLine in gameBoard.consecutivePositions{
                
                let row0 = eachLine[0].row, row1 = eachLine[1].row, row2 = eachLine[2].row
                let col0 = eachLine[0].col, col1 = eachLine[1].col, col2 = eachLine[2].col
                
                guard (gameBoard[row0,col0]?.occupiedBy as? AchiPlayer) != nil else { continue }
                guard (gameBoard[row1,col1]?.occupiedBy as? AchiPlayer) != nil else { continue }
                guard (gameBoard[row2,col2]?.occupiedBy as? AchiPlayer) != nil else { continue }
                
                if (gameBoard[row0,col0]?.occupiedBy as? AchiPlayer) == (gameBoard[row1,col1]?.occupiedBy as? AchiPlayer){
                    if (gameBoard[row1,col1]?.occupiedBy as? AchiPlayer) == (gameBoard[row2,col2]?.occupiedBy as? AchiPlayer){
                        return GameState.GameOverIsWinForPlayer((gameBoard[2,2]?.occupiedBy)!)
                    }
                    continue
                }
            }
        }
        
        return GameState.GameContinues
    }
    
    private func checkBoardStateForDraw(gameBoard : GameBoard) -> GameState{
        
        for eachPlayer in (gameBoard.players as! [AchiPlayer]){
            if getAllPossibleMovesForPlayer(gameBoard: gameBoard, gamePlayer: eachPlayer).count > 0 {
                return GameState.GameContinues
            }
        }
        
        return GameState.GameOverDraw
    }

    

    public func getAllPossibleMovesForPlayer(gameBoard: GameBoard, gamePlayer: GamePlayer) -> [GameMove] {
        
        var allPossibleMoves = [[GameMove]]()
        
        // If a player has not placed all his coins on the table. Possibles moves must only include moves to place a coin in any open position on the board.
        let allPositionsForPlayer = gameBoard.getAllPositionsForPlayer(player: gamePlayer)
        
        if allPositionsForPlayer.count < gameBoard.coinCountPerPlayer{
            let allOpenPositions = gameBoard.getAllOpenPositions()
            return allOpenPositions.map({ (eachPos) -> GameMove in
                return GameMove(startPos: nil, endPos: eachPos, player: gamePlayer)
            })
        }
        
        allPossibleMoves = allPositionsForPlayer.map { (gamePosition) -> [GameMove] in
            
            let openPositions = gamePosition.adjacentOpenPositions(gameBoard: gameBoard)
            
            var allMovesForPosition = [GameMove]()
            
            for eachOpenPosition in openPositions{
                let tempMove = GameMove(startPos: gamePosition, endPos: eachOpenPosition, player: gamePlayer)
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
            guard gameMove.startPos != nil else {
                return false
            }
        }
        
        // If Destination is occuiped return false.
        guard try! gameBoard.isOccupied(gamePos: gameMove.endPos) == false else {
            return false
        }
        
        // To Position should not be occupied.
        guard let _ = try? gameBoard.isOccupied(gamePos: gameMove.endPos) == false else {
            return false
        }
        
        return true
    }
}
