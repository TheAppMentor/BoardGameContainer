//
//  GameScoringEngine.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 25/08/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

public protocol GameScoringEngine {
    func getScoreForGameStateForPlayer(player : GamePlayer) -> Int
}
