//
//  AchiPlayer.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 18/06/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import SpriteKit

public enum GamePlayerColor {
    case Red
    case Black
    
    func imageName() -> String{
        switch self {
        case .Red:
            return "RedCoin.png"
            //return UIImage(named: "RedCoin.png")
        case .Black:
            return "BlackCoin.png"
            //return UIImage(named: "BlackCoin.png")
        }
    }
}

public class AchiPlayer: NSObject, GamePlayer {

    public var playerId: Int
    public var coinNode : SKSpriteNode
    
    public init(color : GamePlayerColor) {
        self.playerId = UUID().uuidString.hashValue
        self.coinNode = SKSpriteNode(imageNamed: color.imageName())
        //super.init()
    }
}

extension AchiPlayer {
    public static func ==(lhs : AchiPlayer, rhs : AchiPlayer) -> Bool {
        return lhs.playerId == rhs.playerId
    }
}

