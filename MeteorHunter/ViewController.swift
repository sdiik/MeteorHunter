//
//  ViewController.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    private struct Constants {
        static let sceneTransistionDuration: Double = 0.2
    }
    
    private var gameScene: GameScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        startNewGame(animated: false)
        
        MusicManager.shared.playBackgroundMusic()
    }
    
    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}

extension ViewController {
    
    private func startNewGame(animated: Bool = false) {
        gameScene = GameScene(size: view.frame.size)
        gameScene!.scaleMode = .aspectFill
        gameScene!.gameSceneDelegate = self
        
        show(gameScene!, animated: animated)
    }
    
    private func resumeGame(animated: Bool = false, completion:(()->())? = nil) {
        let skView = view as! SKView
        
        if animated {
            skView.presentScene(gameScene!,
                                transition: SKTransition.crossFade(withDuration: Constants.sceneTransistionDuration))
            let delay = Constants.sceneTransistionDuration * Double(NSEC_PER_SEC)
            let time = DispatchTime.now() + delay / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time, execute: { [weak self] in
                self?.gameScene!.isPaused = false
                completion?()
            })
        }
        else {
            skView.presentScene(gameScene!)
            gameScene!.isPaused = false
            completion?()
        }
    }
    
    private func showMainMenuScene(animated: Bool) {
        let scene = MainMenuScene(size: view.frame.size)
        scene.mainMenuSceneDelegate = self
        gameScene!.isPaused = true
        show(scene, animated: animated)
    }
    
    private func showGameOverScene(animated: Bool) {
        let scene = GameOverScene(size: view.frame.size)
        scene.gameOverSceneDelegate = self
        gameScene!.isPaused = true
        show(scene, animated: animated)
    }

    private func show(_ scene: SKScene, scaleMode: SKSceneScaleMode = .aspectFill, animated: Bool = true) {
        guard let skView = view as? SKView else {
            preconditionFailure()
        }

        scene.scaleMode = .aspectFill

        if animated {
            skView.presentScene(scene, transition: SKTransition.crossFade(withDuration: Constants.sceneTransistionDuration))
        } else {
            skView.presentScene(scene)
        }
    }
    
}

extension ViewController : GameSceneDelegate {

    func didTapMainMenuButton(in gameScene: GameScene) {
        showMainMenuScene(animated: true)
    }
    
    func playerDidLose(withScore score: Int, in gameScene:GameScene) {
        showGameOverScene(animated: true)
    }
    
}

extension ViewController : MainMenuSceneDelegate {
    
    func mainMenuSceneDidTapResumeButton(_ mainMenuScene: MainMenuScene) {
        resumeGame(animated: true) {
            mainMenuScene.removeFromParent()
        }
    }
    
    func mainMenuSceneDidTapRestartButton(_ mainMenuScene: MainMenuScene) {
        startNewGame(animated: true)
    }
    
    func mainMenuSceneDidTapInfoButton(_ mainMenuScene:MainMenuScene) {
        let alertController = UIAlertController(title: "About",
                                                message: "Copyright 2025 Ahmad Shiddiq. All rights reserved.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}

extension ViewController : GameOverSceneDelegate {
    func gameOverSceneDidTapRestartButton(_ gameOverScene: GameOverScene) {
        startNewGame(animated: true)
    }
}

extension ViewController {
    
    private func configureView() {
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        #if DEBUG
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
        #endif
    }
    
}
