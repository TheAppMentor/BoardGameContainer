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

    var chipPositions : [GameBoardPosition] {get}
    var gameRulesEngine : GameRulesEngine {get}
    
    func generateGameBoard(gameType : GameType)
    func getSpriteNodeForGameBoard(size : CGSize) -> SKSpriteNode?    
}
