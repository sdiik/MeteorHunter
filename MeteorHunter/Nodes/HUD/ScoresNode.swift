//
//  ScoresNode.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

import SpriteKit

class ScoresNode: SKLabelNode {
    
    var value: Int = 0 {
        didSet {
            update()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        fontSize = 18.0
        fontColor = UIColor(white: 1, alpha: 0.7)
        horizontalAlignmentMode = .left;
        
        update()
    }
    
    func update() {
        text = "Score: \(value)"
    }
}
