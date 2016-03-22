//
//  ANMovingGround.swift
//  Nimble Ninja
//
//  Created by Alex Nguyen on 2015-12-30.
//  Copyright © 2015 Alex Nguyen. All rights reserved.
//

import Foundation
import SpriteKit

class ANMovingGround: SKSpriteNode {
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    let COLOR_TWO = UIColor(red: 120.0/255.0, green: 195.0/255.0, blue: 118.0/255.0, alpha: 1.0)
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width*2, size.height))
        //Add an anchorpoint
        anchorPoint = CGPointMake(0, 0.5)
        
        for var i = 0; i < NUMBER_OF_SEGMENTS; i++ {
            var segmentColor: UIColor!
        
            if i % 2 == 0 {
                segmentColor = COLOR_ONE
            } else{
                segmentColor = COLOR_TWO
            }
            //Create a segment node
            let segment = SKSpriteNode(color: segmentColor, size: CGSizeMake(self.size.width/CGFloat(NUMBER_OF_SEGMENTS), self.size.height))
            //Set anchor
            segment.anchorPoint = CGPointMake(0.0, 0.5)
            //Set the position
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, 0)
            addChild(segment)
        }
    }
    //Need this to make XCode happy 
    required init?(coder aDecorder: NSCoder){
        fatalError("init(Coder: ) has not been implmented ")
    }
    
    func start(){
        let adjustedDuration = NSTimeInterval(frame.size.width / kDefaultXToMovePerSecond)
        
        //Apply actions to a node. This one will move by X
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: adjustedDuration/2)
        //Reset the position
        let resetPosition = SKAction.moveToX(0, duration: 0)
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        
        runAction(SKAction.repeatActionForever(moveSequence))
        
    }
    func stop(){
        self.removeAllActions()
    }
}