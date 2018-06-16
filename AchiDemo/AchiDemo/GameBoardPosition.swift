//
//  GameBoardPosition.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

protocol GameBoardPosition {
    
    var col : UInt8 {get set}
    var row : UInt8 {get set}
    var occupiedBy : GamePlayer? {get set}
    
}

//extension GameBoardPosition {
//    static func < (lhs: GameBoardPosition, rhs: GameBoardPosition) -> Bool {
//        
//        if lhs.row == rhs.row {
//            return lhs.col < rhs.col
//        }
//        
//        return lhs.row < rhs.row
//    }
//    
//    static func == (lhs: GameBoardPosition, rhs: GameBoardPosition) -> Bool {
//        return (lhs.row == rhs.row && lhs.col == rhs.col)
//    }
//}
