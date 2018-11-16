import Foundation
import SpriteKit
import GameKit
import GameplayKit
import BoardGameContainerFramework

public class GameScene: SKScene {
    
    public override init(size: CGSize) {
        super.init(size: size)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var gameBoardHandler : GameBoardHandler!
    public var whoseChanceToMove = "first"
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("We Got a touch.... ")

        if let touch = touches.first {
            let touchedNodes = nodes(at: touch.location(in: self))
            let node = touchedNodes.first!
            print("Tapped Node Name is.... \(node.name)")
            switch node.name{
            case "emptyNode" :
                print(node.userData)
                
                let gameBoard = gameBoardHandler._gameBoard

                 var player = (gameBoard.players?.last as! GamePlayer) // Ugly.. I know.
                if whoseChanceToMove == "first" {
                    player = (gameBoard.players?.first as! GamePlayer)
                    whoseChanceToMove = "second"
                }else{
                    player = (gameBoard.players?.last as! GamePlayer)
                    whoseChanceToMove = "first"
                }
                
                let moveResult = gameBoard.make(move: GameMove(startPos: nil,
                                              endPos: AchiBoardPosition(row: (node.userData!["row"]! as! UInt8), col: (node.userData!["col"]! as! UInt8), occupiedBy:  player),
                               player: player))
                
                print("Move Done... \(moveResult)")
                print("Move Player is : \(player)")
                print("Game Board AFter Move is : \(gameBoard)")

            //try! gameBoard.updatePosition(position: AchiBoardPosition(row : (node.userData!["row"]! as! UInt8), col : (node.userData!["col"]! as! UInt8), occupiedBy : gameBoard.players?.first as? GamePlayer))
            default :
                print("We are exiting in defalut... !!!!!!")
                break
            }
        }else{
            print("We are exiting in \(touches.first) ... !!!!!!")

        }
    }
    
}
