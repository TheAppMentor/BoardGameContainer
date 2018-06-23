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
    
    let startPos : GameBoardPosition?
    let endPos : GameBoardPosition
    let player : GamePlayer
    
    public init(startPos : GameBoardPosition?, endPos : GameBoardPosition, player : GamePlayer) {
        self.startPos = startPos
        self.endPos = endPos
        self.player = player
    }
    
    public override var description: String{
        return "Game Move : \n \t Start Pos : \(String(describing: startPos)) \n \t End   Pos : \(endPos)"
    }
}


//extension GameMove{
//    public static func == (lhs: Self, rhs: Self) -> Bool{
//        
//        let lhs = lhs as! GameMove
//        let rhs = rhs as! GameMove
//
//        print("Checking Game MOves for equaliaty...")
//        return (
//            (lhs.startPosition?.row == rhs.startPosition?.row && lhs.startPosition?.col == rhs.startPosition?.col) &&
//            (lhs.endPostion.row == rhs.endPostion.row && lhs.endPostion.col == rhs.endPostion.col))
//        
//        //TODO : I have omitted player here.. check it out. Need to make these Game players equatable.
//    }
//}

