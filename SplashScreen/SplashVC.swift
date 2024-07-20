//
//  SplashVC.swift
//  SplashScreen
//
//  Created by Artyom Petrichenko on 20.07.2024.
//

import UIKit

protocol SplashAnimatable {
    func animateLoader()
    func transitionToMain()
}

class SplashVC: UIViewController {
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loaderInnerView: UIView!
    @IBOutlet weak var hiText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        loaderView.layer.cornerRadius = 20
        loaderInnerView.layer.cornerRadius = 20
    }
}
 
extension SplashVC {

    func animateLoader() {
        UIView.animate(withDuration: 3,
                       animations: {
            self.loaderView.transform = CGAffineTransform(rotationAngle: Double.pi)
            self.loaderInnerView.transform = CGAffineTransform(rotationAngle: -Double.pi / 2)
            self.loaderInnerView.backgroundColor = UIColor.white
            self.hiText.layer.isHidden = false
            self.hiText.layer.shadowOpacity = 0.5
            self.hiText.transform = CGAffineTransform(rotationAngle: Double.pi / 2)
        }, completion: { _ in
            UIView.animate(withDuration: 1.2,
                           animations: {
                self.loaderView.transform = CGAffineTransform(rotationAngle: Double.pi / 2)
                self.loaderView.transform = CGAffineTransform(rotationAngle: -Double.pi)
                self.loaderInnerView.layer.cornerRadius = self.loaderInnerView.frame.size.width / 2
                self.loaderInnerView.clipsToBounds = true
                self.loaderView.transform = CGAffineTransform(rotationAngle: -3 * Double.pi / 2)
            }, completion: { _ in
                self.loaderInnerView.layer.opacity = 0
                self.loaderView.layer.cornerRadius = self.loaderView.frame.size.width / 2
                self.loaderView.clipsToBounds = true
                UIView.animate(withDuration: 1.5, animations: {
                    self.loaderView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    self.loaderView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    self.loaderView.transform = CGAffineTransform(scaleX: 10, y: 10)
                })
            })
        })
    }
    
    func transitionToMain() {
        if let window = UIApplication.shared.windows.first {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                UIView.transition(with: window,
                                  duration: 0.5,
                                  options: .transitionCurlUp,
                                  animations: {
                    window.rootViewController = mainVC
                })
            }
        }
    }
}
