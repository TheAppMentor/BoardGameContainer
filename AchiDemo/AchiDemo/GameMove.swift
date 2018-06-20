//
//  GameMove.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 15/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import GameplayKit

public class GameMove : NSObject, GKGameModelUpdate {
    
    //A value assigned and read by GameplayKit to rate the desirability of a move in your game.
    public var value: Int = 0
    
    let startPosition : GameBoardPosition?
    let endPostion : GameBoardPosition
    let player : GamePlayer
    
    public init(startPosition : GameBoardPosition?, endPostion : GameBoardPosition, player : GamePlayer) {
        self.startPosition = startPosition
        self.endPostion = endPostion
        self.player = player
    }
}
