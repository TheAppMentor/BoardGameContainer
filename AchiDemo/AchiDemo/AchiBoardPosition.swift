//
//  AchiBoardPosition.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/19/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

struct AchiBoardPosition : GameBoardPosition {
    var row: UInt8
    var col: UInt8
    var occupiedBy: GamePlayer?
}
