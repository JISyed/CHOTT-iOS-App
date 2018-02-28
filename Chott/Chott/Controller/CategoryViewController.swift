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
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
                present(timerVC, animated: true, completion: nil)
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

