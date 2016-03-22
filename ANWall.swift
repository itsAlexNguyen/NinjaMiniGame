//
//  ANWall.swift
//  Nimble Ninja
//
//  Created by Alex Nguyen on 2015-12-30.
//  Copyright © 2015 Alex Nguyen. All rights reserved.
//

import Foundation
import SpriteKit

class ANWall: SKSpriteNode {
    
    let WALL_WIDTH: CGFloat = 30.0
    let WALL_HEIGHT: CGFloat = 50.0
    let WALL_COLOR = UIColor.blackColor()
    
    init(){
        let size = CGSizeMake(WALL_WIDTH, WALL_HEIGHT)
        super.init(texture: nil, color: WALL_COLOR, size: size)
        loadPhysicsBody(size)
        startMoving()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func loadPhysicsBody(size: CGSize){
        //Set up physics body
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = wallCategory  //What type it is
        physicsBody?.contactTestBitMask = heroCategory //What does it come in contact (collision) with?
        physicsBody?.affectedByGravity = false //Don't want to deal with gravity
    }
    
    func startMoving() {
        let moveLeft = SKAction.moveByX(-kDefaultXToMovePerSecond, y: 0, duration: 1.0)
        self.runAction(SKAction.repeatActionForever(moveLeft))
    }
    func stopMoving(){
        //Stop wall from moving
        self.removeAllActions()
    }
    
}