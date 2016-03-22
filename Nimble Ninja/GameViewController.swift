//
//  GameViewController.swift
//  Nimble Ninja
//
//  Created by Alex Nguyen on 2015-12-30.
//  Copyright (c) 2015 Alex Nguyen. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    //We will create the scene later so use "!"
    var scene: GameScene!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view
        let skView = view as! SKView
        //Don't want multiple touch
        skView.multipleTouchEnabled = false
        
        //Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //Present the scene
        skView.presentScene(scene)
       
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
