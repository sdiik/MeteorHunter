//
//  MainMenuScene.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

import SpriteKit

protocol MainMenuSceneDelegate: AnyObject {
    
    func mainMenuSceneDidTapResumeButton(_ mainMenuScene: MainMenuScene)
    func mainMenuSceneDidTapRestartButton(_ mainMenuScene: MainMenuScene)
    func mainMenuSceneDidTapInfoButton(_ mainMenuScene: MainMenuScene)
}

class MainMenuScene: MenuScene {
    
    private var infoButton: Button?
    private var resumeButton: Button?
    private var restartButton: Button?
    private var buttons: [Button]?
    weak var mainMenuSceneDelegate: MainMenuSceneDelegate?

    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        configureButtons()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        AnalyticsManager.sharedInstance.trackScene("MainMenuScene")
    }

    private func configureButtons() {
        infoButton = Button(normalImageNamed: ImageName.MenuButtonInfoNormal.rawValue,
                            selectedImageNamed: ImageName.MenuButtonInfoNormal.rawValue)
        infoButton!.touchUpInsideEventHandler = infoButtonTouchUpInsideHandler()
        infoButton!.position = CGPoint(x: scene!.size.width - 40.0,
                                       y: scene!.size.height - 25.0)
        addChild(infoButton!)
    
        resumeButton = Button(normalImageNamed: ImageName.MenuButtonResumeNormal.rawValue,
                              selectedImageNamed: ImageName.MenuButtonResumeNormal.rawValue)
        resumeButton!.touchUpInsideEventHandler = resumeButtonTouchUpInsideHandler()
        
        restartButton = Button(normalImageNamed: ImageName.MenuButtonRestartNormal.rawValue,
                               selectedImageNamed: ImageName.MenuButtonRestartNormal.rawValue)
        restartButton!.touchUpInsideEventHandler = restartButtonTouchUpInsideHandler()
        
        buttons = [resumeButton!, restartButton!]
        let horizontalPadding: CGFloat = 20.0
        var totalButtonsWidth: CGFloat = 0.0

        for (index, button) in buttons!.enumerated() {
            totalButtonsWidth += button.size.width
            totalButtonsWidth += index != buttons!.count - 1 ? horizontalPadding : 0.0
        }

        var buttonOriginX = frame.width / 2.0 + totalButtonsWidth / 2.0

        for (_, button) in buttons!.enumerated() {
            button.position = CGPoint(x: buttonOriginX - button.size.width/2,
                                      y: button.size.height * 1.1)
            addChild(button)
            
            buttonOriginX -= button.size.width + horizontalPadding
            
            let rotateAction = SKAction.rotate(byAngle: CGFloat(.pi/180.0 * 5.0), duration: 2.0)
            let sequence = SKAction.sequence([rotateAction, rotateAction.reversed()])
            button.run(SKAction.repeatForever(sequence))
        }
    }
    
    private func resumeButtonTouchUpInsideHandler() -> TouchUpInsideEventHandler {
        return { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.mainMenuSceneDelegate?.mainMenuSceneDidTapResumeButton(strongSelf)
        }
    }
    
    private func restartButtonTouchUpInsideHandler() -> TouchUpInsideEventHandler {
        return { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.mainMenuSceneDelegate?.mainMenuSceneDidTapRestartButton(strongSelf)
        }
    }
    
    private func infoButtonTouchUpInsideHandler() -> TouchUpInsideEventHandler {
        return { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.mainMenuSceneDelegate?.mainMenuSceneDidTapInfoButton(strongSelf)
        }
    }
    
}
