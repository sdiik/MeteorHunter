//
//  GameOverScene.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

import SpriteKit

protocol GameOverSceneDelegate: AnyObject {
    func gameOverSceneDidTapRestartButton(_ gameOverScene: GameOverScene)
}

class GameOverScene: MenuScene {
    
    private var restartButton: Button?
    private var buttons: [Button]?
    weak var gameOverSceneDelegate: GameOverSceneDelegate?
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        configureButtons()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        AnalyticsManager.sharedInstance.trackScene("GameOverScene")
    }

    private func configureButtons() {
        restartButton = Button(
            normalImageNamed: ImageName.MenuButtonRestartNormal.rawValue,
            selectedImageNamed: ImageName.MenuButtonRestartNormal.rawValue)
        
        restartButton!.touchUpInsideEventHandler = restartButtonTouchUpInsideHandler()
        
        buttons = [restartButton!]
        let horizontalPadding: CGFloat = 20.0
        var totalButtonsWidth: CGFloat = 0.0
        
        for (index, button) in (buttons!).enumerated() {
            
            totalButtonsWidth += button.size.width
            totalButtonsWidth += index != buttons!.count - 1 ? horizontalPadding : 0.0
        }
         
        var buttonOriginX = frame.width / 2.0 + totalButtonsWidth / 2.0
         
        for (_, button) in (buttons!).enumerated() {
            button.position = CGPoint(
                x: buttonOriginX - button.size.width/2,
                y: button.size.height * 1.1)
            
            addChild(button)
            
            buttonOriginX -= button.size.width + horizontalPadding
            
            let rotateAction = SKAction.rotate(byAngle: CGFloat(.pi/180.0 * 5.0), duration: 2.0)
            let sequence = SKAction.sequence([rotateAction, rotateAction.reversed()])
            
            button.run(SKAction.repeatForever(sequence))
        }
    }
    
    private func restartButtonTouchUpInsideHandler() -> TouchUpInsideEventHandler {
        let handler = { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.gameOverSceneDelegate?.gameOverSceneDidTapRestartButton(strongSelf)
        }
        
        return handler
    }
    
}
