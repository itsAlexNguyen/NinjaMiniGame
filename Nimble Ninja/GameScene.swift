//
//  GameScene.swift
//  Nimble Ninja
//
//  Created by Alex Nguyen on 2015-12-30.
//  Copyright (c) 2015 Alex Nguyen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround: ANMovingGround!
    var hero: ANHero!
    var isStarted = false
    var isGameOver = false
    
    var cloudGenerator: ANCloudGenerator!
    var wallGenerator: ANWallGenerator!
    
    var currentLevel = 0
    
    
    override func didMoveToView(view: SKView) {
        //Set the background colour
        backgroundColor = UIColor(red: 120.0/255.0, green: 220.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        
        //Add objects to scene
        addMovingGround()
        addHero()
        addCloudGenerator()
        addWallGenerator()
        addStartLabel()
        addGameOverLabel()
        addPhysicsWorld()
        addPointsLabel()
    }
    func addMovingGround(){
        //Create the ground (brown, width of frame width, height of 20)
        movingGround = ANMovingGround(size: CGSizeMake(view!.frame.width, 20))
        movingGround.position = CGPointMake(0, view!.frame.height/2)
        //Add ground to the scene
        self.addChild(movingGround)
    }
    func addHero() {
        //Add hero and position
        hero = ANHero()
        hero.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2)
        
        //Add hero to game
        addChild(hero)
        hero.breathe()
    }
    func addCloudGenerator(){
        //Add cloud generator
        cloudGenerator = ANCloudGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        cloudGenerator.position = view!.center
        addChild(cloudGenerator)
        cloudGenerator.populate(6)
        cloudGenerator.startGeneratingWithSpawnTime(5)
    }
    func addWallGenerator(){
        //Add wall generator
        wallGenerator = ANWallGenerator(color: UIColor.clearColor(), size: view!.frame.size)
        wallGenerator.position = view!.center
        addChild(wallGenerator)
    }
    func addStartLabel(){
        //Add start label
        let tapToStartLabel = SKLabelNode(text: "TAP TO START!")
        tapToStartLabel.name = "tapToStartLabel"
        tapToStartLabel.position.x = view!.center.x
        tapToStartLabel.position.y = view!.center.y + 70
        tapToStartLabel.fontColor = UIColor.blackColor()
        addChild(tapToStartLabel)
        tapToStartLabel.runAction(blinkAnimation())
    }
    func addPointsLabel(){
        let pointsLabel = ANPointsLabel(num: 0, type: "Score")
        pointsLabel.name = "pointsLabel"
        pointsLabel.position = CGPointMake(view!.center.x, view!.frame.size.height-25)
        addChild(pointsLabel)
        
        let highScoreLabel = ANPointsLabel(num: loadHighScore(), type: "High Score")
        highScoreLabel.name = "highScoreLabel"
        highScoreLabel.position = CGPointMake(view!.center.x, 25.0)
        addChild(highScoreLabel)
        
    }
    func addGameOverLabel(){
        //Add Game Over label
        let gameOverLabel = SKLabelNode(text: "GAME OVER")
        gameOverLabel.name = "gameOverLabel"
        gameOverLabel.position.x = view!.center.x
        gameOverLabel.position.y = view!.center.y + 70
        gameOverLabel.alpha = 0 //Don't display it though
        gameOverLabel.fontColor = UIColor.blackColor()
        addChild(gameOverLabel)
    }
    func addPhysicsWorld(){
        //Add physics world
        physicsWorld.contactDelegate = self
    }
    func loadHighScore() -> Int{
        let defaults = NSUserDefaults.standardUserDefaults()
        let highscore = defaults.integerForKey("highscore")
        return highscore
    }
    func startGame(){
        childNodeWithName("tapToStartLabel")?.removeAllActions()
        childNodeWithName("tapToStartLabel")?.alpha = 0
        hero.stop()
        movingGround.start()
        hero.startRunning()
        wallGenerator.startGeneratingWallsEvery(1)
        isStarted = true
    }
    func gameOver(){
        isGameOver = true;
        //Stop everything
        hero.fall()
        wallGenerator.stopWalls()
        movingGround.stop()
        hero.stop()
        childNodeWithName("gameOverLabel")?.alpha = 1
        childNodeWithName("gameOverLabel")?.runAction(blinkAnimation())
        
    }
    func restart() {
        //Stop all timers
        cloudGenerator.stopGenerating()
        
        //Create a new Scene
        let newScene = GameScene(size: view!.bounds.size)
        newScene.scaleMode = .AspectFill
        
        //Present new Scene
        view!.presentScene(newScene)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isGameOver{
            restart()
        }else if !isStarted {
            startGame()
        } else {
            hero.flip()
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if wallGenerator.wallsTracker.count > 0 {
            let wall = wallGenerator.wallsTracker[0] as ANWall
            let wallLocation = wallGenerator.convertPoint(wall.position, toNode: self)
            if wallLocation.x < hero.position.x {
                wallGenerator.wallsTracker.removeAtIndex(0)
                let pointsLabel = childNodeWithName("pointsLabel") as! ANPointsLabel
                pointsLabel.increment()
                
                if pointsLabel.number % kNumberPointsPerLevel == 0 {
                    currentLevel++
                    wallGenerator.stopGenerating()
                    wallGenerator.startGeneratingWallsEvery(kLevelGenerationTimes[currentLevel])
                }
                
                let highScoreLabel = childNodeWithName("highScoreLabel") as! ANPointsLabel
                if pointsLabel.number > highScoreLabel.number {
                    highScoreLabel.increment()
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setInteger(highScoreLabel.number, forKey: "highscore")
                }
            }
        }
        
    }

    // MARK: - SKPhysicsContactDelagate
    func didBeginContact(contact: SKPhysicsContact) {
        if !isGameOver {
            gameOver()
        }
    }
    // MARK: - Animations
    func blinkAnimation() -> SKAction {
        let duration = 0.4
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        return SKAction.repeatActionForever(blink)
    }
    
    
    
    
}
