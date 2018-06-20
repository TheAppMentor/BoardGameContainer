import UIKit
import PlaygroundSupport
import SpriteKit
import GameKit
import GameplayKit

import BoardGameContainerFramework

let gameColCount : CGFloat = 3
let gameRowCount : CGFloat = 3

let gameCoinSize = CGSize(width: 90, height: 90)
let boardSize = CGSize(width: 300, height: 300)
//let spacingBetweenCoins = (boardSize.width - (gameCoinSize.width * gameRowCount))/(gameRowCount) + (gameCoinSize.width) //Assumes we have a squre board with square coins.

let totalFreeSpace = (boardSize.width - (gameRowCount * gameCoinSize.width))
let spacingBetweenCoins = totalFreeSpace/2

let sceneSize = CGSize(width: 300.0, height: 300.0)

let mainScene = SKScene(size: sceneSize)
mainScene.backgroundColor = UIColor.lightGray

//Set up the view and show the scene
let view = SKView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.presentScene(mainScene)
view.backgroundColor = UIColor.green


func createSimpleGameBoard() -> GameBoard? {
    let redPlayer = AchiPlayer(color: .Red)
    let blackPlayer = AchiPlayer(color: .Black)
    
    let achiGameBoard = GameBoardFactory.createGameBoard(gameType: .AchiGame, players: [redPlayer, blackPlayer])
    achiGameBoard?.getAllPositions()
    return achiGameBoard
}

let gameBoard = createSimpleGameBoard() as! AchiGameBoard

try gameBoard.updatePosition(position: AchiBoardPosition(row : 0, col : 1, occupiedBy : gameBoard.players?.first as? GamePlayer))
try gameBoard.updatePosition(position: AchiBoardPosition(row : 2, col : 2, occupiedBy : gameBoard.players?.last as? GamePlayer))




func makeCoin() -> SKSpriteNode{
    let coin = SKSpriteNode(color: UIColor.lightGray, size: gameCoinSize)
    coin.texture = SKTexture(image: UIImage(named: "RedCoin.png")!)
    return coin
}

func respostionCoinNodeOnBoard(coinPosition : CGPoint, coinSize : CGSize, boardSize : CGSize) -> CGPoint{
    let shiftedPoint = CGPoint(x: coinPosition.x + (-boardSize.width/2 + coinSize.width/2.0), y: coinPosition.y + (-boardSize.height/2 + coinSize.height/2.0))
    return shiftedPoint
}

func getSpriteNodeForGBoard(gameBoard : GameBoard) -> SKSpriteNode{
    let board = SKSpriteNode.init(color: UIColor.white, size: boardSize)
    
    for eachPostion in gameBoard.getAllPositions(){
        let coinNode = getCoinNodeForPosition(gridPosition: eachPostion)
        let position = getGridPosition(gridPosition: eachPostion, boardSize: boardSize)
        coinNode?.position = respostionCoinNodeOnBoard(coinPosition: position, coinSize: gameCoinSize, boardSize: boardSize)
        
        board.addChild(coinNode!)
        print("\t \((coinNode?.position)!)")
    }
    return board
}


func getGridPosition(gridPosition : GameBoardPosition, boardSize : CGSize) -> CGPoint{
    
        for eachCol in 0..<gameBoard.colCount{
            for eachRow in 0..<gameBoard.rowCount{
         
                if eachCol == gridPosition.col && eachRow == gridPosition.row{
                    let xPos = (CGFloat(eachCol) * spacingBetweenCoins) + (CGFloat(eachCol) * gameCoinSize.width)
                    let yPos = (CGFloat(eachRow) * spacingBetweenCoins) + (CGFloat(eachRow) * gameCoinSize.width)

                    print("Processing --> Row : \(eachRow) : Col : \(eachCol)")
                    print("\t xPos : \(xPos)   : yPos : \(yPos)")
                    return CGPoint(x: xPos, y: yPos)
                }
            }
        }
    return CGPoint.zero
}

func getCoinNodeForPosition(gridPosition : GameBoardPosition) -> SKSpriteNode?{
    if let player = gridPosition.occupiedBy{
        let theNode = player.coinNode
        theNode.size = gameCoinSize
        
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let pulse = SKAction.sequence([fadeOut, fadeIn])
//        let pulseThreeTimes = SKAction.repeat(pulse,
//                                              count: 3)
        let pulseForever = SKAction.repeatForever(pulse)
        
        //theNode.run(pulseForever)
        
        return theNode
    }
    return SKSpriteNode(color: UIColor.lightGray, size: gameCoinSize)
}


print(gameBoard.getAllPositions())
let boardSprite = getSpriteNodeForGBoard(gameBoard: gameBoard)
boardSprite.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height/2)
mainScene.addChild(boardSprite)

PlaygroundPage.current.liveView = view
