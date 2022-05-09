//
//  MenuViewController.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 09/05/2022.
//

import UIKit

class MenuViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var itemOne: UIView!
    
    @IBOutlet weak var itemTwo: UIView!
    
    
    @IBOutlet weak var itemThree: UIView!
    
    
    @IBOutlet weak var itemFour: UIView!
    
    
    @IBOutlet weak var itemFive: UIView!
    
    @IBOutlet weak var menuScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemOne.layer.cornerRadius = 10
        itemTwo.layer.cornerRadius = 10
        itemThree.layer.cornerRadius = 10
        itemFour.layer.cornerRadius = 10
        itemFive.layer.cornerRadius = 10
        self.menuScrollView.delegate=self

    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Animation for first menu item
        if menuScrollView.contentOffset.y >= 100.0 {
            // Your animation code goes HERE... //
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.itemOne.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                      })
        }
        if menuScrollView.contentOffset.y < 100.0 {
            // Your animation code goes HERE... //
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.itemOne.transform = CGAffineTransform(scaleX: 1, y: 1)
                      })
        }
        
        // Animation for second menu item
        if menuScrollView.contentOffset.y >= 250.0 {
            // Your animation code goes HERE... //
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.itemTwo.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                      })
        }
        if menuScrollView.contentOffset.y < 250.0 {
            // Your animation code goes HERE... //
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.itemTwo.transform = CGAffineTransform(scaleX: 1, y: 1)
                      })
        }
        
        // Animation for third menu item
        if menuScrollView.contentOffset.y >= 500.0 {
            // Your animation code goes HERE... //
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.itemThree.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                      })
        }
        if menuScrollView.contentOffset.y < 500.0 {
            // Your animation code goes HERE... //
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.itemThree.transform = CGAffineTransform(scaleX: 1, y: 1)
                      })
        }
    }
}
