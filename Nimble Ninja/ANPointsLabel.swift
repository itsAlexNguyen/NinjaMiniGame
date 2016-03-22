//
//  ANPointsLabel.swift
//  Nimble Ninja
//
//  Created by Alex Nguyen on 2015-12-31.
//  Copyright © 2015 Alex Nguyen. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ANPointsLabel: SKLabelNode {
    
    var number = 0;
    var type = ""
    
    init(num: Int, type: String){
        super.init()
        number = num
        self.type = type
        text = type + ": \(num)"
        fontColor = UIColor.brownColor()
        fontSize = 25
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func increment(){
        number++
        text = type + ": \(number)"
    }
}