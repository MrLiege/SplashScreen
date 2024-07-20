//
//  SceneDelegate.swift
//  SplashScreen
//
//  Created by Artyom Petrichenko on 20.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private lazy var splashPresenter: SplashPresentable? = SplashPresenter(parentView: window!.rootViewController!.view)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupWindow(with: windowScene)
        splashPresenter?.present()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
    }
    
    private func setupWindow(with scene: UIWindowScene) {
        window = UIWindow(windowScene: scene)
        window?.windowLevel = .normal
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}
