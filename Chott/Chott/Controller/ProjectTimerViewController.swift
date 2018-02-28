//
//  ProjectTimerViewController.swift
//  Chott
//
//  Created by Jibran Syed on 2/22/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class ProjectTimerViewController: UIViewController 
{
    static let STRYBRD_ID = "TimerVC"
    
    @IBOutlet weak var imgViewCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var viewColoredRing: CircularView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnFinish: UIButton!
    
    private var currentCategory: ChottCategory = .art  // Needed to avoid init()
    private var currentProject: ChottProjectData? 
    private var updateTimer: Timer?
    private var startingTime = Date()
    private var currentTime = Date()
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Initialize the timer which will update the UI
        self.updateTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { (_) in
            self.updateTimerUI()
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        let liteColor = ChottCategory.liteColor(of: self.currentCategory)
        
        self.imgViewCategory.image = ChottCategory.icon(of: self.currentCategory)
        self.imgViewCategory.tintColor = liteColor
        self.lblCategory.text = ChottCategory.name(of: self.currentCategory)
        self.lblCategory.textColor = liteColor
        self.lblProjectName.text = self.currentProject!.name
        self.lblProjectName.textColor = liteColor
        self.lblTimer.text = "0:00"
        self.lblTimer.textColor = liteColor
        self.viewColoredRing.backgroundColor = ChottCategory.regularColor(of: self.currentCategory)
        self.btnFinish.setTitleColor(liteColor, for: .normal)
        self.btnFinish.backgroundColor = ChottCategory.darkColor(of: self.currentCategory)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) 
    {
        // Remove update timer
        self.updateTimer?.invalidate()
        self.updateTimer = nil
        
        super.viewDidDisappear(animated)
    }
    
    
    func setup(withProject project: ChottProjectData?, andStartTime startTime: Date)
    {
        self.currentProject = project
        self.currentCategory = ChottCategory(rawValue: Int(self.currentProject!.categoryId))!
        self.resetTime(to: startTime)
    }
    
    
    private func resetTime(to newTime: Date)
    {
        self.startingTime = newTime
        self.currentTime = newTime
        
        // Declare to ChottDataService that a session is being timed,
        // so that it can backup the current session of the app quits for some reason
        ChottDataService.declareTimingSession(ofProject: self.currentProject!, withStartTime: newTime)
        
        print("Project ID: \(self.currentProject!.id!.uuidString)")
        print(UserDefaults.standard.bool(forKey: ChottDataService.DefaultsKeys.isCurrentlyTiming.rawValue))
        print(UserDefaults.standard.object(forKey: ChottDataService.DefaultsKeys.currentProjectId.rawValue) as! String)
        print(UserDefaults.standard.integer(forKey: ChottDataService.DefaultsKeys.currentCategory.rawValue))
        print(UserDefaults.standard.object(forKey: ChottDataService.DefaultsKeys.currentStartTime.rawValue) as! Date)
    }
    
    
    private func updateTimerUI()
    {
        self.currentTime = Date()
        self.lblTimer.text = DateUtility.getTimerString(from: self.startingTime, to: self.currentTime)
    }
    
    
    private func quitTimerVC()
    {
        // Declare to ChottDataService that we stopped timing the session,
        // so that it doesn't think the app quit on us and we intend to end the session
        ChottDataService.declareStoppingSession()
        
        print(UserDefaults.standard.bool(forKey: ChottDataService.DefaultsKeys.isCurrentlyTiming.rawValue))
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onFinishPressed(_ sender: Any) 
    {
        ChottDataService.addSession(forProject: self.currentProject!, startTime: self.startingTime, andEndTime: Date())
        
        self.quitTimerVC()
    }
    
    @IBAction func onRestartPressed(_ sender: Any) 
    {
        let alert = UIAlertController(title: "Reset Timer?", message: "Reset the timer for this session of '\(self.currentProject!.name!)'?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in                
            self.resetTime(to: Date())
            self.lblTimer.text = "0:00"
        })
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onCancelPressed(_ sender: Any) 
    {
        let alert = UIAlertController(title: "Cancel Session?", message: "Cancel timing this session of '\(self.currentProject!.name!)'?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in                
            self.quitTimerVC()
        })
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
