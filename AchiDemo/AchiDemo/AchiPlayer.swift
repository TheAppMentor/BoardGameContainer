//
//  AchiPlayer.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 18/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation

class AchiPlayer: NSObject, GamePlayer {

    var playerId: Int
    
    override init() {
        self.playerId = UUID().uuidString.hashValue
        super.init()
    }
}

extension AchiPlayer {
    static func ==(lhs : AchiPlayer, rhs : AchiPlayer) -> Bool {
        return lhs.playerId == rhs.playerId
        
    }
}

