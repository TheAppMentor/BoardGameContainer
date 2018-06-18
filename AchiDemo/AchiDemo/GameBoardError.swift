//
//  GameBoardError.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 18/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

enum GameBoardError : Error {

    case attemptToFetchInvalidGamePositionRow
    case attemptToFetchInvalidGamePositionCol
    case attemptToFetchInvalidGamePosition
    case attemptToMakeInvalidMove
    case invalidPosition
}
