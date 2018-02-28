//
//  UIViewController+CustomTransitions.swift
//  Chott
//
//  Created by Jibran Syed on 2/28/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

// Credit to Devslopes

// Override default transition animations
extension UIViewController
{
    private static let _vcLateralTransitionDuration = 0.3                // In seconds
    private static let _vcLateralTransitionType = kCATransitionPush      // Slide over the old view controller like a Navigation Controller
    
    
    func presentLaterally(_ viewControllerToPresent: UIViewController, completion: (() -> Void)? = nil)
    {
        let transition = CATransition()
        transition.duration = UIViewController._vcLateralTransitionDuration
        transition.type = UIViewController._vcLateralTransitionType
        transition.subtype = kCATransitionFromRight // Slide from the right
        
        // Present next view with animation
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: completion)
    }
    
    func dismissLaterally(completion: (() -> Void)? = nil)
    {
        let transition = CATransition()
        transition.duration = UIViewController._vcLateralTransitionDuration
        transition.type = UIViewController._vcLateralTransitionType
        transition.subtype = kCATransitionFromLeft // Slide from the left
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: completion)
    }    
}
