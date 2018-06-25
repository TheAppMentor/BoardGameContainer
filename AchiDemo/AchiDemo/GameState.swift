//
//  GameState.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 23/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

public enum GameState {    
    case GameContinues
    case GameOverIsWinForPlayer (GamePlayer)
    case GameOverDraw
}
