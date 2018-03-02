//
//  CategoryViewController.swift
//  Chott
//
//  Created by Jibran Syed on 2/20/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController 
{
    static let STRYBRD_ID = "CategoryVC"
    
    @IBOutlet weak var viewMusicPanel: UIView!
    @IBOutlet weak var viewWritingPanel: UIView!
    @IBOutlet weak var viewCornerRadiusMeasure: UIView!
    @IBOutlet weak var constraintButtonsToEdge: NSLayoutConstraint!
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    // Call this when bounds need to be read (after Auto-Layout does its job) before VC becomes visible
    override func viewDidLayoutSubviews() 
    {
        super.viewDidLayoutSubviews()
        
        // Only run this on iPhone X
        if UIApplication.shared.delegate?.window??.safeAreaInsets != .zero
        {            
            let buttonRadius = self.viewCornerRadiusMeasure.bounds.height - self.constraintButtonsToEdge.constant
            let radius = CGSize(width: buttonRadius, height: buttonRadius)
            
            self.viewMusicPanel.layoutIfNeeded()    // Force the bounds to the correct size (for iPhone X)
            self.viewMusicPanel.clipsToBounds = true
            let musicBtnPath = UIBezierPath(roundedRect: viewMusicPanel.bounds, byRoundingCorners: [.bottomLeft], cornerRadii: radius)
            let musicBtnMask = CAShapeLayer()
            musicBtnMask.path = musicBtnPath.cgPath
            self.viewMusicPanel.layer.mask = musicBtnMask
            
            self.viewWritingPanel.layoutIfNeeded()  // Force the bounds to the correct size (for iPhone X)
            self.viewWritingPanel.clipsToBounds = true
            let writingBtnPath = UIBezierPath(roundedRect: viewWritingPanel.bounds, byRoundingCorners: [.bottomRight], cornerRadii: radius)
            let writingBtnMask = CAShapeLayer()
            writingBtnMask.path = writingBtnPath.cgPath
            self.viewWritingPanel.layer.mask = writingBtnMask
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        self.view.window?.backgroundColor = AppColors.appBkg
        
        // Check if there was a session being timed (could be the case if the app quited or crashed)
        if ChottDataService.isCurrentlyTimingSession()
        {
            let restoredSession = ChottDataService.restoreCurrentSessionData()
            
            print("ID        : \(restoredSession.currentProjectId.uuidString)")
            print("StartTime : \(restoredSession.currentStartTime)")
            
            let foundProject = ChottDataService.searchProject(byId: restoredSession.currentProjectId)
            
            if let project = foundProject
            {
                // Launch TimerVC from CategoryVC
                guard let timerVC = self.storyboard?.instantiateViewController(withIdentifier: ProjectTimerViewController.STRYBRD_ID) as? ProjectTimerViewController else 
                { 
                    debugPrint("ERROR: Could not get TimerVC from CategoryVC! Cancelling saved session!")
                    ChottDataService.declareStoppingSession()
                    return 
                }
                
                timerVC.setup(withProject: project, andStartTime: restoredSession.currentStartTime)
                present(timerVC, animated: false, completion: nil)
            }
            else
            {
                // No project was found, so don't bother restoring session
                ChottDataService.declareStoppingSession()
            }
        }
    }
    
    
    @IBAction func onCategoryBtnPressed(_ sender: UIButton) 
    {        
        guard let selectProjectVC = storyboard?.instantiateViewController(withIdentifier: SelectProjectViewController.STRYBRD_ID) as? SelectProjectViewController else { debugPrint("ERROR: Could not get SelectProjectVC!"); return }
        
        // Using button tags between 1 to 4 to represent different catagories. See ChottCategories.swift
        let selectedCategory = ChottCategory(rawValue: sender.tag)!
        selectProjectVC.setup(with: selectedCategory)
        
        presentLaterally(selectProjectVC)
    }
    
    
    
}

