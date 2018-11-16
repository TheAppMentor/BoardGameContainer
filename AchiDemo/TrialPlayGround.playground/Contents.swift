import UIKit
import PlaygroundSupport
import SpriteKit
import GameKit
import GameplayKit
import BoardGameContainerFramework

let sceneSize = CGSize(width: 300.0, height: 300.0)

let mainScene = GameScene(size: sceneSize)
mainScene.backgroundColor = UIColor.lightGray

//Set up the view and show the scene
let view = SKView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.presentScene(mainScene)

let gameBoardHandler = GameBoardHandler()
//var gameBoard =  gameBoardHandler.createSimpleGameBoard() as! AchiGameBoard
mainScene.gameBoardHandler = gameBoardHandler

func renderGameBoard(){
    let boardSprite = gameBoardHandler.getSpriteNodeForGBoard()
    boardSprite.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height/2)
    mainScene.removeAllChildren()
    mainScene.addChild(boardSprite)
}

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true

Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
     //print(gameBoard.getAllPositions())
    renderGameBoard()
}.fire()

