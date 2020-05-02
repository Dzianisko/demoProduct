//
//  ProjectScene.swift
//  Product
//
//  Created by Dzianis Machuha on 5/1/20.
//  Copyright © 2020 Dzianis Machuha. All rights reserved.
//

import SpriteKit
import GameplayKit

class ProjectScene: SKScene {
    
    var label : SKLabelNode?
    
    override func didMove(to view: SKView) {

        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode

        if let label = self.label {
            label.position = CGPoint(x: 0, y: view.frame.height / 3)
        }

    }
    
}
