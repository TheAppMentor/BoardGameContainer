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
    public var consecutivePositions : [[GameBoardPosition]]{
        return _consecutivePositions
    }
    
    private lazy var _consecutivePositions :  [[GameBoardPosition]] = []
    
    public var currentlyActivePlayer : GamePlayer
    var allPlayers : [GamePlayer]
    
    var redPlayer : GamePlayer{
        return allPlayers.first!
    }

    var blackPlayer : GamePlayer{
        return allPlayers.last!
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
        
        super.init()
        _consecutivePositions = getConsecutivePositions()
    }
    
    public func evaluateGameStateForBoard() -> GameState {
        return evaluateBoardState(gameBoard: self)
    }
    
    func evaluateScoreForBoard(player : GamePlayer) -> Int{
        
        // 10 -> Best State .. (Win for Player)
        //  0 -> Bad State for Player (Loss For Player)

        switch evaluateGameStateForBoard() {

        case .GameContinues:
            // Return a more refined score here. Need to check which of the players has an advantage.
            // Number of Moves to Win for Player.
            // Number of Moves to Win for opposnet.

            return 5

        case .GameOverIsWinForPlayer(let winningPlayer):
           return (winningPlayer.playerId == player.playerId) ? 10 : 0

        case .GameOverDraw:
            return 5
        }
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
    
    public func make(move : GameMove) -> Bool{
        
        // Check if Game Move From Position is valid.
        guard let fromPos = move.startPos else {
            return false
        }
        
        guard isValidRowCol(row: fromPos.row, col: fromPos.col) else {
            return false
        }
        
        // Check if Game Move To Position is valid.
        guard isValidRowCol(row: move.endPos.row, col: move.endPos.col) else {
            return false
        }
        
        if gameRulesEngine.isValidMove(gameBoard: self, gameMove: move){
            let newRow : UInt8 =  move.endPos.row
            let newCol : UInt8 =  move.endPos.col

            self[newRow,newCol] = AchiBoardPosition.init(row: newRow, col: newCol, occupiedBy: move.player)
            currentlyActivePlayer = getOtherPlayer()
            
            // Empty the spot we just moved from.
            guard let startPos = move.startPos else {
                return false
            }
            self[startPos.row,startPos.col] = AchiBoardPosition.init(row: startPos.row, col: startPos.col, occupiedBy: nil)

            return true
        }
        return false
    }
    
    private func getConsecutivePositions() -> [[GameBoardPosition]]{
        
        var allLines = [[GameBoardPosition]]()
        
            // Make all Horizontal Lines.
            for eachRow in 0..<self.rowCount{
                var tempArr = [GameBoardPosition]()
                for eachCol in 0..<self.colCount{
                    tempArr.append(AchiBoardPosition(row: eachRow, col: eachCol, occupiedBy: nil))
                }
                allLines.append(tempArr)
            }
            
            // Make all Vertical Lines.
            for eachCol in 0..<self.colCount{
                var tempArr = [GameBoardPosition]()
                for eachRow in 0..<self.rowCount{
                    tempArr.append(AchiBoardPosition(row: eachRow, col: eachCol, occupiedBy: nil))
                }
                allLines.append(tempArr)
            }
            
            // Make all Diagonal Lines.
            let diag1  = [AchiBoardPosition(row: 0, col: 0, occupiedBy: nil), AchiBoardPosition(row: 1, col: 1, occupiedBy: nil),AchiBoardPosition(row: 2, col: 2, occupiedBy: nil)]
            let diag2  = [AchiBoardPosition(row: 0, col:2 , occupiedBy: nil), AchiBoardPosition(row: 1, col: 1, occupiedBy: nil),AchiBoardPosition(row: 2, col: 0, occupiedBy: nil)]
            
            allLines.append(diag1)
            allLines.append(diag2)
        
        return allLines
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
        if let gameMove = gameModelUpdate as? GameMove{
            let moveResult = make(move: gameMove)
            if moveResult == false{
                assertionFailure("Apply game Model update failed.")
            }
        }else{
            assertionFailure("Apply game Model update failed. ==> Could not type case GameModelUpdate to GAMEMOVE.")
        }
    }
    
    /**
     * Returns the score for the specified player. A higher value indicates a better position for
     * the player than a lower value. Required by GKMinmaxStrategist to determine which
     * GKGameModelUpdate is the most advantageous for a given player. If the player is invalid, or
     * not a part of the game model, returns NSIntegerMin.
     */
    public func score(for player: GKGameModelPlayer) -> Int{
        guard let player = player as? GamePlayer else {
            return Int(INT8_MIN)
        }
        return evaluateScoreForBoard(player: player)
    }
    
    /**
     * Returns YES if the specified player has reached a win state, NO if otherwise. Note that NO does not
     * necessarily mean that the player has lost. Optionally used by GKMinmaxStrategist to improve move selection.
     */
    public func isWin(for player: GKGameModelPlayer) -> Bool{
        let boardState = evaluateGameStateForBoard()
        
        switch boardState {
        case .GameOverIsWinForPlayer(let winningPlayer):
            return winningPlayer.playerId == player.playerId
        default:
            return false
        }
    }
    
    /**
     * Returns YES if the specified player has reached a loss state, NO if otherwise. Note that NO does not
     * necessarily mean that the player has won. Optionally used by GKMinmaxStrategist to improve move selection.
     */
    public func isLoss(for player: GKGameModelPlayer) -> Bool{

        let boardState = evaluateGameStateForBoard()

        switch boardState {
        case .GameOverIsWinForPlayer(let winningPlayer):
            //TODO: Watch out.. this will fail if we have more than one player in a game.
            return winningPlayer.playerId != player.playerId
        default:
            return false
        }
    }
    
    public func unapplyGameModelUpdate(_ gameModelUpdate: GKGameModelUpdate){
        
    }
    
    
    //Prashanth : TODO : Test cases for these fellows... they are all part of the score calcuator.
    // How bout .. putting them in their own class.... ? GameScoring engine? GameBoard is getting too big.
    public func chancesOfNextMoveResultingInWin(player : GamePlayer) -> CGFloat{
    // May be we need to expand this to says.. how many winning moves the guy has with the next move.
        let allPossMoves = gameRulesEngine.getAllPossibleMovesForPlayer(gameBoard: self, gamePlayer: player)
        let winningMoves = allPossMoves.filter({ (move) -> Bool in
            if let gameCopy = self.copy() as? AchiGameBoard{
                if gameCopy.make(move: move) == true {
                   return gameCopy.isWin(for: player)
                }
            }
            return false
        })
        
        if winningMoves.count > 0 {
            return CGFloat(winningMoves.count/allPossMoves.count)
        }
     return 0.0
    }

    public func chancesOfNextMoveResultingInLossForPlayer(player : GamePlayer) -> CGFloat{
        // May be we need to expand this to says.. how many winning moves the guy has with the next move.
        let allPossMoves = gameRulesEngine.getAllPossibleMovesForPlayer(gameBoard: self, gamePlayer: player)
        let losingMoves = allPossMoves.filter({ (move) -> Bool in
            if let gameCopy = self.copy() as? AchiGameBoard{
                if gameCopy.make(move: move) == true {
                    return gameCopy.isLoss(for: player)
                }
            }
            return false
        })
        
        if losingMoves.count > 0 {
            return CGFloat(losingMoves.count/allPossMoves.count)
        }
        return 0.0
    }

    public func changesOfMoveResultingInWinForOpponentOnHisNextMove(player : GamePlayer) -> CGFloat{
        // May be we need to expand this to says.. how many winning moves the guy has with the next move.
        let allPossMoves = gameRulesEngine.getAllPossibleMovesForPlayer(gameBoard: self, gamePlayer: player)

        let theMovesThatSuck = allPossMoves.filter({ (move) -> Bool in

            if let gameCopy = self.copy() as? AchiGameBoard{
                if gameCopy.make(move: move) == true {

                if (gameCopy.isWin(for: player)) {return false}
                if (gameCopy.isLoss(for: player)) {return false}
    
                    let allSecondGenMoves = gameCopy.gameRulesEngine.getAllPossibleMovesForPlayer(gameBoard: gameCopy, gamePlayer: gameCopy.getOtherPlayer())
                    
                    let winningMovesForOpponent = allSecondGenMoves.filter({ (move) -> Bool in
                        gameCopy.make(move: move)
                        return gameCopy.isWin(for: gameCopy.getOtherPlayer())
                    })
                    
                    if winningMovesForOpponent.count > 0 {
                        // Here we have an opportunity to refine this further.
                        // Right now if the opponent has even 1 winning move.. we say good and go ahead.
                        // This assumes, he wil make that move.. but we could look at how many winning moves he has.. that will increase the likelyhood of him making those changes. etc...
                        return true
                    }
                    
                }
            }
            return false
        })
        
        if theMovesThatSuck.count > 0 {
            return CGFloat(theMovesThatSuck.count/allPossMoves.count)
        }
        return 0.0
    }

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
            if gameRulesEngine.getAllPossibleMovesForPlayer(gameBoard: gameBoard, gamePlayer: eachPlayer).count > 0 {
                return GameState.GameContinues
            }
        }
        
        return GameState.GameOverDraw
    }
    
}
