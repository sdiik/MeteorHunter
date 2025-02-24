//
//  PlayerSpaceship.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

import CoreGraphics
import SpriteKit

class PlayerSpaceship: Spaceship {
    
    fileprivate let engineBurstEmitter = SKEmitterNode(fileNamed: "PlayerSpaceshipEngineBurst")!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let size = CGSize(width: 64, height: 50)
        
        self.init(texture: SKTexture(imageNamed: ImageName.PlayerSpaceship.rawValue),
                  color: UIColor.brown,
                  size: size)
        
        name = NSStringFromClass(PlayerSpaceship.self)
        
        configureCollisions()
        configureEngineBurst()
    }

    fileprivate func configureCollisions() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.usesPreciseCollisionDetection = true
        physicsBody!.allowsRotation = false
        
        physicsBody!.categoryBitMask = CategoryBitmask.playerSpaceship.rawValue
        physicsBody!.collisionBitMask =
            CategoryBitmask.enemyMissile.rawValue |
            CategoryBitmask.screenBounds.rawValue
        
        physicsBody!.contactTestBitMask =
            CategoryBitmask.enemySpaceship.rawValue |
            CategoryBitmask.enemyMissile.rawValue
    }
    
    fileprivate func configureEngineBurst() {
        engineBurstEmitter.position = CGPoint(x: -size.width/2 - 5.0, y: 0.0)
        addChild(engineBurstEmitter)
    }

    func launchMissile() {
        let missile = Missile.playerMissile()
        missile.position = CGPoint(x: frame.maxX + 10.0, y: position.y)
        missile.zPosition = zPosition - 1
        
        scene!.addChild(missile)
        
        let velocity: CGFloat = 600.0
        let moveDuration = scene!.size.width / velocity
        let missileEndPosition = CGPoint(x: position.x + scene!.size.width, y: position.y)
        
        let moveAction = SKAction.move(to: missileEndPosition, duration: TimeInterval(moveDuration))
        let removeAction = SKAction.removeFromParent()
        missile.run(SKAction.sequence([moveAction, removeAction]))

        scene!.run(SKAction.playSoundFileNamed(SoundName.MissileLaunch.rawValue, waitForCompletion: false))
    }
    
}
