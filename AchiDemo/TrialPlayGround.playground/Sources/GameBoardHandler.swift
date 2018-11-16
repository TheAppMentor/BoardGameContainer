import UIKit
import PlaygroundSupport
import SpriteKit
import GameKit
import GameplayKit
import BoardGameContainerFramework

public class GameBoardHandler {

    let gameColCount : CGFloat = 3
    let gameRowCount : CGFloat = 3

    public var _gameBoard : GameBoard
    let gameCoinSize = CGSize(width: 90, height: 90)
    let boardSize = CGSize(width: 300, height: 300)
    lazy var spacingBetweenCoins = totalFreeSpace/2
    lazy var totalFreeSpace = (boardSize.width - (gameRowCount * gameCoinSize.width))

    public init(){
        _gameBoard = GameBoardHandler.createSimpleGameBoard()!
    }

    static public func createSimpleGameBoard() -> GameBoard? {
        let redPlayer = AchiPlayer(color: .Red)
        let blackPlayer = AchiPlayer(color: .Black)
        
        let achiGameBoard = GameBoardFactory.createGameBoard(gameType: .AchiGame, players: [redPlayer, blackPlayer])
//        achiGameBoard?.getAllPositions()
        return achiGameBoard
    }
    
    public func getSpriteNodeForGBoard() -> SKSpriteNode{
        let board = SKSpriteNode.init(color: UIColor.white, size: boardSize)
        
        for eachPostion in _gameBoard.getAllPositions(){
            let coinNode = getCoinNodeForPosition(gridPosition: eachPostion)
            let position = getGridPosition(gridPosition: eachPostion, boardSize: boardSize)
            let repositionedPosition = respostionCoinNodeOnBoard(coinPosition: position, coinSize: gameCoinSize, boardSize: boardSize)
            coinNode?.position = repositionedPosition
            if coinNode!.name == "redNode"{
                print("🐶🐶🐶🐶🐶 => Trying to add a red node...");
                print("board Childer ... \(board.children)")
                print("coin Node is.. \(coinNode!)")
            }
            board.addChild(coinNode!)
        }
        print("Finsished adding.. nodes to be the board....")
        print("board Children Count ... \(board.children.count)")

        print("board Childer ... \(board.children)")
        return board
    }


    
    
    
    
    
    
    // ===============================
    //        Helper functions
    // ===============================
    
//    try gameBoard.updatePosition(position: AchiBoardPosition(row : 0, col : 1, occupiedBy : gameBoard.players?.first as? GamePlayer))
//    try gameBoard.updatePosition(position: AchiBoardPosition(row : 2, col : 2, occupiedBy : gameBoard.players?.last as? GamePlayer))
    
    func respostionCoinNodeOnBoard(coinPosition : CGPoint, coinSize : CGSize, boardSize : CGSize) -> CGPoint{
        //print("ccoinPosition : \(coinPosition) :  coinSize : \(coinSize), boardSize : \(boardSize) ");
        let shiftedPoint = CGPoint(x: coinPosition.x + (-boardSize.width/2 + coinSize.width/2.0), y: coinPosition.y + (-boardSize.height/2 + coinSize.height/2.0))
        return shiftedPoint
    }
    
    func getGridPosition(gridPosition : GameBoardPosition, boardSize : CGSize) -> CGPoint{
        
        for eachCol in 0..<_gameBoard.colCount{
            for eachRow in 0..<_gameBoard.rowCount{
                
                let invRow = (_gameBoard.rowCount - 1) - eachRow

                if eachCol == gridPosition.col && eachRow == gridPosition.row{
                    let xPos = (CGFloat(eachCol) * spacingBetweenCoins) + (CGFloat(eachCol) * gameCoinSize.width)
                    let yPos = (CGFloat(invRow) * spacingBetweenCoins) + (CGFloat(invRow) * gameCoinSize.width)
                    
                    //print("Processing --> Row : \(eachRow) : Col : \(eachCol)")
                    //print("\t Returning Position = xPos : \(xPos)   : yPos : \(yPos)")
                    return CGPoint(x: xPos, y: yPos)
                }
            }
        }
        return CGPoint.zero
    }
    
    func getCoinNodeForPosition(gridPosition : GameBoardPosition) -> SKSpriteNode?{
        if let player = gridPosition.occupiedBy {
            //let theNode = player.coinNode
            let theNode = SKSpriteNode(color: UIColor.red, size: gameCoinSize)
            theNode.name = "redNode" 
            theNode.size = gameCoinSize
            
            //let fadeOut = SKAction.fadeOut(withDuration: 1)
            //let fadeIn = SKAction.fadeIn(withDuration: 1)
            //let pulse = SKAction.sequence([fadeOut, fadeIn])
            //let pulseThreeTimes = SKAction.repeat(pulse,count: 3)
            //let pulseForever = SKAction.repeatForever(pulse)
            //theNode.run(pulseForever)
            
            theNode.userData = ["row" : gridPosition.row, "col" : gridPosition.col]
            print("Returning a Red Code.. From : getCoinNodeForPosition")
            return theNode
        }
        
        //Empty Space Node :
        let emptySpaceNode = SKSpriteNode(color: UIColor.lightGray, size: gameCoinSize)
        emptySpaceNode.name = "emptyNode"
        emptySpaceNode.userData = ["row" : gridPosition.row, "col" : gridPosition.col]
        return emptySpaceNode
    }
    
}
