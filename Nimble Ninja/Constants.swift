//
//  Constants.swift
//  Nimble Ninja
//
//  Created by Alex Nguyen on 2015-12-30.
//  Copyright © 2015 Alex Nguyen. All rights reserved.
//

import Foundation
import UIKit
//Change ground height
let KMLGroundHeight: CGFloat = 20.0
//For wall synchronization
let kDefaultXToMovePerSecond: CGFloat = 320.0
//Collision Detection
let heroCategory: UInt32 = 0x1 << 0
let wallCategory: UInt32 = 0x1 << 1
//Game varaibles
let kNumberPointsPerLevel = 5
let kLevelGenerationTimes: [NSTimeInterval] = [1.0, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1, 0.01]