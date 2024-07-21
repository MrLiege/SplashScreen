//
//  SplashVC.swift
//  SplashScreen
//
//  Created by Artyom Petrichenko on 20.07.2024.
//

import UIKit

protocol SplashAnimatable {
    func animateLoader()
}

class SplashVC: UIViewController {
    
    @IBOutlet weak var loaderImage: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
}
 
extension SplashVC: SplashAnimatable {
    
    func animateLoader() {
        UIView.animate(withDuration: 1, animations: {
            self.loaderImage.transform = CGAffineTransform(rotationAngle: .pi)
        }) { _ in
            UIView.animate(withDuration: 1, animations: {
                self.loaderImage.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                self.loaderImage.tintColor = .systemOrange
            }) { _ in
                self.loaderImage.image = UIImage(systemName: "basketball.fill")
                UIView.animate(withDuration: 1, animations: {
                    self.loaderImage.transform = .identity
                }, completion: { _ in
                    UIView.animate(withDuration: 1, animations: {
                        self.loaderImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    }, completion: {_ in
                        self.bounceAnimation()
                    })
                })
            }
        }
    }
    
    func bounceAnimation() {
        let originalPosition = loaderImage.center
        let originalPositionHigh = CGPoint(x: loaderImage.center.x, y: loaderImage.center.y - 50)
        let newPosition = CGPoint(x: loaderImage.center.x, y: textImageView.frame.minY)
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            self.loaderImage.center = newPosition
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                self.loaderImage.center = originalPositionHigh
            }) { _ in
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
                    self.loaderImage.center = originalPosition
                }) { _ in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.rotateTextImageView()
                    })
                }
            }
        }
    }
    
    func rotateTextImageView() {
        UIView.animate(withDuration: 1, animations: {
            self.setupRandomText()
            self.textImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
    }
    
    func setupRandomText() {
        let count = 4
        let randomTextNumber = Int.random(in: 1...count)
        let randomTextName = "splashText\(randomTextNumber)"
        textImageView.image = UIImage(named: randomTextName)
        textImageView.isHidden = false
    }
}
