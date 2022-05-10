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
        // Following code is used to animate menu items depending on the current Y offset of the scrollview.
        // When the Y offset reaches the speicified value, the view is transformed to 0.1 of its x and y scale.
        
        // Shrinks first menu item view (to 0.1 of original size) when scroll offset is greater than 130
        if menuScrollView.contentOffset.y >= 130.0 {
            UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: {
                self.itemOne.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                      })
        }
        
        // Re-expands first menu item view when scroll offset is less than 130
        
        if menuScrollView.contentOffset.y < 130.0 {
            UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: {
                self.itemOne.transform = CGAffineTransform(scaleX: 1, y: 1)
                      })
        }
        
        // Shrinks second menu item view (to 0.1 of original size) when scroll offset is greater than 315
        if menuScrollView.contentOffset.y >= 315.0 {
            UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: {
                self.itemTwo.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                      })
        }
        
        // Re-expands second menu item view when scroll offset is less than 315
        if menuScrollView.contentOffset.y < 315.0 {
            UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: {
                self.itemTwo.transform = CGAffineTransform(scaleX: 1, y: 1)
                      })
        }
        
        // Shrinks third menu item view (to 0.1 of original size) when scroll offset is greater than 495
        if menuScrollView.contentOffset.y >= 495.0 {
            UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: {
                self.itemThree.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                      })
        }
        
        // Re-expands third menu item view when scroll offset is less than 495
        if menuScrollView.contentOffset.y < 495.0 {
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.itemThree.transform = CGAffineTransform(scaleX: 1, y: 1)
                      })
        }
    }
}
