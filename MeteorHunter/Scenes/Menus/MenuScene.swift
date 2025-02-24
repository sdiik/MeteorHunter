//
//  MenuScene.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

import SpriteKit

class MenuScene: SKScene {
    
    private var background: SKSpriteNode?
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        configureBackground()
    }

    private func configureBackground() {
        background = SKSpriteNode(imageNamed: ImageName.MenuBackgroundPhone.rawValue)
        background!.size = size
        background!.position = CGPoint(x: size.width/2, y: size.height/2)
        background!.zPosition = -1000
        addChild(background!)
    }
    
}
