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

class AchiGameBoard : NSObject, GameBoard {
    
    let rowCount : UInt8 = 3
    let colCount : UInt8 = 3
    let coinCountPerPlayer : UInt8 = 3
    
    var currentlyActivePlayer : GamePlayer
    var allPlayers : [GamePlayer]
    
    subscript(row : UInt8, col : UInt8) -> GameBoardPosition? {
        get{
            let matchingPostions = chipPositions.filter({$0.row == row && $0.col == col})
            guard matchingPostions.count == 1 else {
                return nil
            }
            return matchingPostions.first!
        }
        set{
            guard isValidRowCol(row: row, col: col) else {
                assertionFailure("Attempting to get invalid GamePosition -> row : \(row), col : \(col)")
                return
            }
            chipPositions.removeAll {return ($0.row == row && $0.col == col)}
            chipPositions.append(newValue!)
        }
    }
    
    func isOccupied(gamePos : GameBoardPosition) throws -> Bool{

        let row = gamePos.row
        let col = gamePos.col
        
        if isValidRowCol(row: row, col: col){
            return self[row,col]?.occupiedBy != nil
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
    
    func getAllPositions() -> [GameBoardPosition] {
        return chipPositions
    }
    
    func getAllPositionsForPlayer(player : GamePlayer) -> [GameBoardPosition]{
        return chipPositions.filter({
            if let occupiedPos = $0.occupiedBy{
                return (occupiedPos as! AchiPlayer) == (player as! AchiPlayer)
            }
            return false
        })
    }

    
    func generateGameBoard(gameType: GameType) {
        
    }
    
    func getSpriteNodeForGameBoard(size: CGSize) -> SKSpriteNode? {
        return nil
    }
    
    private var chipPositions : [GameBoardPosition] = []

    private var sortedChipPositions : [GameBoardPosition] {
        //return chipPositions.sorted(by: {$0 < $1})
        return []
    }

    var gameRulesEngine : GameRulesEngine
    
    func drawGameBoardLayout() {
        print("Achi Game Board Drawing... ")
        
        for eachPosition in chipPositions {
        }
    }
    
    init(rulesEngine : GameRulesEngine, players : [GamePlayer]) {
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
    
//    func isValidMove(fromPos : AchiBoardPosition, toPos : AchiBoardPosition) -> Bool{
//        
//        return false
//    }
    
    func make(move : GameMove) -> Bool{
        
        // Check if Game Move From Position is valid.
        if let fromPos = move.startPosition{
            guard isValidRowCol(row: fromPos.row, col: fromPos.col) else {
                return false
            }
        }
        
        // Check if Game Move To Position is valid.
        guard isValidRowCol(row: move.endPostion.row, col: move.endPostion.col) else {
            return false
        }
        
        if gameRulesEngine.isValidMove(gameBoard: self, gameMove: move){
            let newRow : UInt8 =  move.endPostion.row
            let newCol : UInt8 =  move.endPostion.col

            let newGPos = AchiBoardPosition.init(row: newRow, col: newCol, occupiedBy: move.player)
            self[newRow,newCol] = newGPos
            currentlyActivePlayer = move.player
            return true
        }
        
        return false
    }
}


extension AchiGameBoard : GKGameModel {
    func copy(with zone: NSZone? = nil) -> Any {
        return 0
    }
    
    //MARK: GKGameModel Methods
    
    /**
     * Array of instances of GKGameModelPlayers representing players within this game model. When the
     * GKMinmaxStrategist class is used to find an optimal move for a specific player, it uses this
     * array to rate the moves of that player’s opponent(s).
     */
    var players: [GKGameModelPlayer]? {
        return allPlayers
    }
    
    
    /**
     * The player whose turn it is to perform an update to the game model. GKMinmaxStrategist assumes
     * that the next call to the applyGameModelUpdate: method will perform a move on behalf of this player.
     */
    var activePlayer: GKGameModelPlayer? {
        return currentlyActivePlayer
    }
    
    
    /**
     * Sets the data of another game model. All data should be copied over, and should not maintain
     * any pointers to the copied game state. This is used by the GKMinmaxStrategist to process
     * permutations of the game without needing to apply potentially destructive updates to the
     * primary game model.
     */
    func setGameModel(_ gameModel: GKGameModel){
        
    }
    
    
    /**
     * Returns an array of all the GKGameModelUpdates (i.e. actions/moves) that the active
     * player can undertake, with one instance of GKGameModelUpdate for each possible move.
     * Returns nil if the specified player is invalid, is not a part of the game model, or
     * if there are no valid moves available.
     */
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]?{
        return nil
    }
    
    
    /**
     * Applies a GKGameModelUpdate to the game model, potentially resulting in a new activePlayer.
     * GKMinmaxStrategist will call this method on a copy of the primary game model to speculate
     * about possible future moves and their effects. It is assumed that calling this method performs
     * a move on behalf of the player identified by the activePlayer property.
     */
    func apply(_ gameModelUpdate: GKGameModelUpdate){
        
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
