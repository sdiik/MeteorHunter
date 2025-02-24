//
//  Spaceship.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

import SpriteKit

class Spaceship: SKSpriteNode, LifePointsProtocol {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    var didRunOutOfLifePointsEventHandler: DidRunOutOfLifePointsEventHandler? = nil
    
    var lifePoints: Int = 0 {
        didSet {
            if lifePoints <= 0 {
                didRunOutOfLifePointsEventHandler?(self)
            }
        }
    }
    
}
