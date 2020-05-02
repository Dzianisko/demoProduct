//
//  ProjectScene.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class ProjectScene: SKScene {
    
    var label : SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode

        if let label = self.label {
            label.alpha = 0.0
            label.position = CGPoint(x: 0, y: view.frame.height / 4)
        }
        

    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
