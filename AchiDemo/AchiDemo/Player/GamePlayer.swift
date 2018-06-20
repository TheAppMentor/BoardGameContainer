//
//  GamePlayer.swift
//  AchiDemo
//
//  Created by Moorthy, Prashanth on 4/22/18.
//  Copyright © 2018 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

public protocol GamePlayer : GKGameModelPlayer {
    var coinNode : SKSpriteNode {get}
}
