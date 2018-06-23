//
//  AchiBoard.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/19/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import UIKit
import GameKit

public class AchiGameBoard : NSObject, GameBoard {
    
    public let rowCount : UInt8 = 3
    public let colCount : UInt8 = 3
    public let coinCountPerPlayer : UInt8 = 4
    
    public var currentlyActivePlayer : GamePlayer
    var allPlayers : [GamePlayer]
    
    var redPlayer : GamePlayer{
        return allPlayers.first!
    }

    var blackPlayer : GamePlayer{
        return allPlayers.last!
    }
    
    func getOtherPlayer() -> GamePlayer{
        if (currentlyActivePlayer as! AchiPlayer) == (redPlayer as! AchiPlayer) {
            return blackPlayer
        }
        return redPlayer
    }
    
    public subscript(row : UInt8, col : UInt8) -> GameBoardPosition? {
        get{
            let matchingPostions = chipPositions.filter({$0.row == row && $0.col == col})
            guard matchingPostions.count == 1 else {
                return nil
            }
            return matchingPostions.first!
        }
        set{
            chipPositions.removeAll {return ($0.row == row && $0.col == col)}
            chipPositions.append(newValue!)
        }
    }
    
    public func updatePosition(position : GameBoardPosition) throws{
        guard isValidRowCol(row: position.row, col: position.col) else {
            throw GameBoardError.invalidPosition
        }
        self[position.row,position.col] = position
    }
    
    public func isOccupied(gamePos : GameBoardPosition) throws -> Bool{

        if isValidRowCol(row: gamePos.row, col: gamePos.col){
            return self[gamePos.row,gamePos.col]?.occupiedBy != nil
        }
        throw GameBoardError.invalidPosition
    }

    func isValidRowCol(row : UInt8, col : UInt8) -> Bool {
        return isValidRow(row: row) && isValidCol(col: col)
    }
    
    func isValidRow(row : UInt8) -> Bool{
        return row < rowCount
    }

    func isValidCol(col : UInt8) -> Bool{
        return col < colCount
    }
    
    public func getAllPositions() -> [GameBoardPosition] {
        return chipPositions
    }
    
    public func getAllOpenPositions() -> [GameBoardPosition]{
        return chipPositions.filter {$0.occupiedBy == nil}
    }

    
    public func getAllPositionsForPlayer(player : GamePlayer) -> [GameBoardPosition]{
        return chipPositions.filter({
            if let occupiedPos = $0.occupiedBy{
                return (occupiedPos as! AchiPlayer) == (player as! AchiPlayer)
            }
            return false
        })
    }

    
    public func generateGameBoard(gameType: GameType) {
        
    }
    
    public func getSpriteNodeForGameBoard(size: CGSize) -> SKSpriteNode? {
        
        return nil
    }
    
    private var chipPositions : [GameBoardPosition] = []

    private var sortedChipPositions : [GameBoardPosition] {
        //return chipPositions.sorted(by: {$0 < $1})
        return []
    }

    public var gameRulesEngine : GameRulesEngine
    
    func drawGameBoardLayout() {
        print("Achi Game Board Drawing... ")
        
        for eachPosition in chipPositions {
        }
    }
    
    public init(rulesEngine : GameRulesEngine, players : [GamePlayer]) {
        self.gameRulesEngine = rulesEngine
        
        for row in 0..<rowCount{
            for col in 0..<colCount{
                let gamePosition = AchiBoardPosition.init(row: row, col: col, occupiedBy: nil)
                chipPositions.append(gamePosition)
            }
        }
        
        //Set currently active player. Right now we are choosing one of the players at Random.
        self.allPlayers = players
        self.currentlyActivePlayer = players.randomElement()!
    }
    
    public func make(move : GameMove) -> Bool{
        
        // Check if Game Move From Position is valid.
        if let fromPos = move.startPos{
            guard isValidRowCol(row: fromPos.row, col: fromPos.col) else {
                return false
            }
        }
        
        // Check if Game Move To Position is valid.
        guard isValidRowCol(row: move.endPos.row, col: move.endPos.col) else {
            return false
        }
        
        if gameRulesEngine.isValidMove(gameBoard: self, gameMove: move){
            let newRow : UInt8 =  move.endPos.row
            let newCol : UInt8 =  move.endPos.col

            let newGPos = AchiBoardPosition.init(row: newRow, col: newCol, occupiedBy: move.player)
            self[newRow,newCol] = newGPos
            currentlyActivePlayer = getOtherPlayer()
            
            // Empty the spot we just moved from.
            if let startPos = move.startPos{
                let oldGPos = AchiBoardPosition.init(row: startPos.row, col: startPos.col, occupiedBy: nil)
                self[startPos.row,startPos.col] = oldGPos
            }

            return true
        }
        
        return false
    }
}


extension AchiGameBoard : GKGameModel {
    public func copy(with zone: NSZone? = nil) -> Any {
        return 0
    }
    
    //MARK: GKGameModel Methods
    
    /**
     * Array of instances of GKGameModelPlayers representing players within this game model. When the
     * GKMinmaxStrategist class is used to find an optimal move for a specific player, it uses this
     * array to rate the moves of that player’s opponent(s).
     */
    public var players: [GKGameModelPlayer]? {
        return allPlayers
    }
    
    
    /**
     * The player whose turn it is to perform an update to the game model. GKMinmaxStrategist assumes
     * that the next call to the applyGameModelUpdate: method will perform a move on behalf of this player.
     */
    public var activePlayer: GKGameModelPlayer? {
        return currentlyActivePlayer
    }
    
    
    /**
     * Sets the data of another game model. All data should be copied over, and should not maintain
     * any pointers to the copied game state. This is used by the GKMinmaxStrategist to process
     * permutations of the game without needing to apply potentially destructive updates to the
     * primary game model.
     */
    public func setGameModel(_ gameModel: GKGameModel){
        
    }
    
    /**
     * Returns an array of all the GKGameModelUpdates (i.e. actions/moves) that the active
     * player can undertake, with one instance of GKGameModelUpdate for each possible move.
     * Returns nil if the specified player is invalid, is not a part of the game model, or
     * if there are no valid moves available.
     */
    public func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]?{
        let allPossMoves = gameRulesEngine.getAllPossibleMovesForPlayer(gameBoard: self, gamePlayer: player as! GamePlayer)
        return allPossMoves
    }    
    
    /**
     * Applies a GKGameModelUpdate to the game model, potentially resulting in a new activePlayer.
     * GKMinmaxStrategist will call this method on a copy of the primary game model to speculate
     * about possible future moves and their effects. It is assumed that calling this method performs
     * a move on behalf of the player identified by the activePlayer property.
     */
    public func apply(_ gameModelUpdate: GKGameModelUpdate){
        
    }
    
    
    /**
     * Returns the score for the specified player. A higher value indicates a better position for
     * the player than a lower value. Required by GKMinmaxStrategist to determine which
     * GKGameModelUpdate is the most advantageous for a given player. If the player is invalid, or
     * not a part of the game model, returns NSIntegerMin.
     */
    public func score(for player: GKGameModelPlayer) -> Int{
        return 0
    }
    
    
    /**
     * Returns YES if the specified player has reached a win state, NO if otherwise. Note that NO does not
     * necessarily mean that the player has lost. Optionally used by GKMinmaxStrategist to improve move selection.
     */
    public func isWin(for player: GKGameModelPlayer) -> Bool{
        return false
    }
    
    /**
     * Returns YES if the specified player has reached a loss state, NO if otherwise. Note that NO does not
     * necessarily mean that the player has won. Optionally used by GKMinmaxStrategist to improve move selection.
     */
    public func isLoss(for player: GKGameModelPlayer) -> Bool{
        return false
    }
    
    
    public func unapplyGameModelUpdate(_ gameModelUpdate: GKGameModelUpdate){
        
    }
}
