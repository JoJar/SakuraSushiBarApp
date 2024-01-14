//
//  ViewController.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 23/04/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIScrollViewDelegate {
    
//    var container: PersistentContainer!
    let coreDataManager = CoreDataManager.shared

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var flowerImageHome: UIImageView!
    
    @IBOutlet weak var scrollViewHome: UIScrollView!
    @IBOutlet weak var mainImage: UIView!
    // Gradient layer and list which will contain the colours.
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    
    // Colours that make up the gradient
    let gradientOne = UIColor(red: 0.24, green: 0.07, blue: 0.25, alpha: 0.5).cgColor
    let gradientTwo = UIColor(red: 0.18, green: 0.16, blue: 0.16, alpha: 0.75).cgColor
    let gradientFour = UIColor(red: 0.22, green: 0.06, blue: 0.17, alpha: 0.5).cgColor
    let gradientThree = UIColor(red: 0.34, green: 0.09, blue: 0.24, alpha: 0.9).cgColor
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the scroll view delegate
        scrollViewHome.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientFour])
        gradientSet.append([gradientFour, gradientOne])
        
        
        gradient.frame = self.mainView.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        self.mainView.layer.insertSublayer(gradient, at: 0)
        
        animateGradient()
        
        blurEffectView.frame = self.mainView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mainView.insertSubview(blurEffectView, at: 0)
        
        
        
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 7.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.delegate = self
        gradientChangeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            // Get the current Y offset of the scroll view
            let yOffset = scrollView.contentOffset.y
            let originalCenterY = scrollViewHome.center.y

            // Check if the scroll Y axis is greater than 130
            if yOffset > 100 {
                // Calculate the new Y position for the scroll view
                let newYPosition = max(0, -yOffset)

                // Adjust the frame or center position of the scroll view
                
                
                // Alternatively, you can use scrollViewHome.center.y = newYPosition

                // Calculate the scale factor based on the scroll position
                let scaleFactor = max(1 - (yOffset - 100) / 100, 0.5)

                // Apply the transform to the main image
                mainImage.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor).translatedBy(x: 0, y: 0)
                mainImage.frame.origin.y = newYPosition
                scrollViewHome.frame.origin.y = mainImage.frame.height
            } else {
                // Reset the transform and position when the scroll Y axis is less than or equal to 130
                mainImage.transform = .identity
                scrollViewHome.center.y = originalCenterY
            }
        }

}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}

