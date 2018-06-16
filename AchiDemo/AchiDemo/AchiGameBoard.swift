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
    func getSpriteNodeForGameBoard(size: CGSize) -> SKSpriteNode? {
        return nil
    }
    
    var chipPositions : [GameBoardPosition] = []

    var sortedChipPositions : [GameBoardPosition] {
        //return chipPositions.sorted(by: {$0 < $1})
        return []
    }

    var gameRulesEngine : GameRulesEngine
    
    func drawGameBoardLayout() {
        print("Achi Game Board Drawing... ")
        
        for eachPosition in chipPositions {
            eachPosition.row
            eachPosition.col
        }
    }
    
    init(rulesEngine : GameRulesEngine) {
        self.gameRulesEngine = rulesEngine
    }
    
    func isValidMove(from : AchiBoardPosition, to : AchiBoardPosition) -> Bool{
        return false
    }
    
    func move(from : AchiBoardPosition, to : AchiBoardPosition){
        
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
        return nil
    }
    
    
    /**
     * The player whose turn it is to perform an update to the game model. GKMinmaxStrategist assumes
     * that the next call to the applyGameModelUpdate: method will perform a move on behalf of this player.
     */
    var activePlayer: GKGameModelPlayer? {
        return nil
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
