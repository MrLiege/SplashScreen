//
//  SplashPresenter.swift
//  SplashScreen
//
//  Created by Artyom Petrichenko on 20.07.2024.
//

import Foundation
import UIKit

protocol SplashPresentable {
    func present()
    func dismiss(_ closure: @escaping() -> Void)
}

final class SplashPresenter: SplashPresentable {
    
    private let parentView: UIView?
    
    private lazy var splashViewController: SplashVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SplashVC") as? SplashVC else {
            fatalError("Проблема со SplashVC")
        }
        
        return viewController
    }()
    
    init(parentView: UIView?) {
        self.parentView = parentView
    }
    
    func present() {
        parentView!.addSubview(splashViewController.view)
        splashViewController.animateLoader()
    }
    
    func dismiss(_ closure: @escaping () -> Void) {
        splashViewController.transitionToMain()
        splashViewController.view.removeFromSuperview()
        closure()
    }
}
