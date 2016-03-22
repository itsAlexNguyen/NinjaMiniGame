//
//  ANCloud.swift
//  Nimble Ninja
//
//  Created by Alex Nguyen on 2015-12-30.
//  Copyright © 2015 Alex Nguyen. All rights reserved.
//

import Foundation
import SpriteKit

class ANCloud: SKShapeNode {

    init(size: CGSize) {
        super.init()
        let path = CGPathCreateWithEllipseInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), nil)
        self.path = path
        fillColor = UIColor.whiteColor()
        startMoving()
    }

    func startMoving() {
        let moveLeft = SKAction.moveByX(-10, y: 0, duration: 1.0)
        runAction(SKAction.repeatActionForever(moveLeft))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}