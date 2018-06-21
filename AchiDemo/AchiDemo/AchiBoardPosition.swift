//
//  AchiBoardPosition.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/19/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

public struct AchiBoardPosition : GameBoardPosition {
    
    public var row: UInt8
    public var col: UInt8
    public var occupiedBy: GamePlayer?
    
    public init(row : UInt8, col : UInt8, occupiedBy : GamePlayer?) {
        self.row = row
        self.col = col
        self.occupiedBy = occupiedBy
    }
}

extension AchiBoardPosition : Equatable{
    public static func == (lhs: AchiBoardPosition, rhs: AchiBoardPosition) -> Bool {
        return (lhs.row == rhs.row && lhs.col == rhs.col && (lhs.occupiedBy as? AchiPlayer) == (rhs.occupiedBy as? AchiPlayer))
    }
}         
