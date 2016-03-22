//
//  ANWallGenerator.swift
//  Nimble Ninja
//
//  Created by Alex Nguyen on 2015-12-30.
//  Copyright © 2015 Alex Nguyen. All rights reserved.
//

import Foundation
import SpriteKit

class ANWallGenerator: SKSpriteNode {

    var generationTimer: NSTimer?
    var walls = [ANWall]()
    var wallsTracker = [ANWall]()
    
    func startGeneratingWallsEvery(seconds: NSTimeInterval) {
        generationTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
        
    }
    func stopGenerating(){
        //Stop the timer
        generationTimer?.invalidate()
    }

    func generateWall(){
        var scale: CGFloat
        let rand = arc4random_uniform(2) //0 or a 1
        if rand == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        let wall = ANWall()
        wall.position.x = size.width/2 + wall.size.width/2
        wall.position.y = scale * (KMLGroundHeight/2 + wall.size.height/2)
        walls.append(wall)
        wallsTracker.append(wall)
        addChild(wall)
    }
    func stopWalls(){
        stopGenerating() //Stop generating walls
        for wall in walls {
            wall.stopMoving()
        }
    }
}