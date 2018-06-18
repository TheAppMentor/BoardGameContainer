//
//  GameBoardFactory.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

class GameBoardFactory {
    static func createGameBoard(gameType : GameType, players : [GamePlayer]) -> GameBoard?{
        switch gameType {
        case .AchiGame:
            let rulesEngine = AchiGameRulesEngine.init()
            let achiBoard = AchiGameBoard(rulesEngine: rulesEngine, players: players)
            return achiBoard
        case .LenChao:
            break            
        }
    return nil
    }
}
