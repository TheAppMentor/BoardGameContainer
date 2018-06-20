//
//  GameRulesEngine.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

public protocol GameRulesEngine {
    func isValidMove(gameBoard : GameBoard, gameMove : GameMove) -> Bool
    func getAllPossibleMovesForPlayer(gameBoard : GameBoard, gamePlayer : GamePlayer) -> [GameMove]
}
