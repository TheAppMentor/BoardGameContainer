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

protocol GameBoard : GKGameModel {

//    var chipPositions : [GameBoardPosition] {get}
    var gameRulesEngine : GameRulesEngine {get}
    var currentlyActivePlayer : GamePlayer {get set}

    func getAllPositions() -> [GameBoardPosition]
    func getAllPositionsForPlayer(player : GamePlayer) -> [GameBoardPosition]
    
    func make(move : GameMove) -> Bool
    
    func generateGameBoard(gameType : GameType)
    func getSpriteNodeForGameBoard(size : CGSize) -> SKSpriteNode?

    func isOccupied(gamePos : GameBoardPosition) throws -> Bool
}
