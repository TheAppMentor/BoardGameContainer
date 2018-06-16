//
//  GameBoardFactory.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

class GameBoardFactory {
    static func createGameBoard(gameType : GameType) -> GameBoard?{
        switch gameType {
        case .AchiGame:
            let rulesEngine = AchiGameRulesEngine.init()
            return AchiGameBoard(rulesEngine: rulesEngine)
        
        case .LenChao:
            break            
        }
    return nil
    }
}
