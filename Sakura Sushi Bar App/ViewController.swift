//
//  ViewController.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 23/04/2022.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var scrollViewHome: UIScrollView!
    
    @IBOutlet weak var flowerImageHome: UIImageView!
    
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
        //flowerImageHome.image = flowerImageHome.image?.withRenderingMode(.alwaysTemplate)
        //flowerImageHome.tintColor = UIColor.gray
        
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

}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}
