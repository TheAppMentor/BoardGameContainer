//
//  GameBoard.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import GameKit
import SpriteKit

public protocol GameBoard : GKGameModel {
    
    var rowCount : UInt8 {get}
    var colCount : UInt8 {get}
    var coinCountPerPlayer : UInt8 {get}
    var consecutivePositions : [[GameBoardPosition]] {get}
    
    subscript(row : UInt8, col : UInt8) -> GameBoardPosition? {get set}

    var gameRulesEngine : GameRulesEngine {get}
    var currentlyActivePlayer : GamePlayer {get set}

    func getAllPositions() -> [GameBoardPosition]
    func getAllOpenPositions() -> [GameBoardPosition]
    func getAllPositionsForPlayer(player : GamePlayer) -> [GameBoardPosition]
    
    func make(move : GameMove) -> Bool
    
    func generateGameBoard(gameType : GameType)
    func getSpriteNodeForGameBoard(size : CGSize) -> SKSpriteNode?

    func isOccupied(gamePos : GameBoardPosition) throws -> Bool
}
