//
//  GameBoardPosition.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/21/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

public protocol GameBoardPosition {
    var row : UInt8 {get set}
    var col : UInt8 {get set}
    var occupiedBy : GamePlayer? {get set}
    
    func adjacentOpenPositions(gameBoard : GameBoard) -> [GameBoardPosition]
    func adjacentPositions(gameBoard : GameBoard) -> [GameBoardPosition]
    func adjacentAllPositionsAround(gameBoard : GameBoard) -> [GameBoardPosition]
}

extension GameBoardPosition{
    
    public func adjacentPositions(gameBoard : GameBoard) -> [GameBoardPosition]{
        return Array(adjacentAllPositionsAround(gameBoard: gameBoard).filter { return ($0.row != self.row || $0.col != self.col)})        
    }

    public func adjacentAllPositionsAround(gameBoard : GameBoard) -> [GameBoardPosition]{
        
        var fetchedPositions = [GameBoardPosition]()
        
        func fetchAllColumnsAroundRow(row : UInt8){
            // Get from prev Col
            if col > 0{
                fetchedPositions.append(gameBoard[row,(col - 1)]!)
            }
            // Get from next Col
            if col < (gameBoard.colCount - 1){
                fetchedPositions.append(gameBoard[row,col + 1]!)
            }
            // Get from curr Col
            fetchedPositions.append(gameBoard[row,col]!)
        }
        
        // Get All From Prev Row
        if row > 0 {
            fetchAllColumnsAroundRow(row : row - 1)
        }
        
        // Get all from Next Row
        if row < gameBoard.rowCount - 1{
            fetchAllColumnsAroundRow(row : row + 1)
        }
        
        // Get All From Current Row
            fetchAllColumnsAroundRow(row: row)
        
        return fetchedPositions
    }
    
    public func adjacentOpenPositions(gameBoard : GameBoard) -> [GameBoardPosition]{
        return self.adjacentPositions(gameBoard: gameBoard).filter({$0.occupiedBy == nil})
    }
    
}
