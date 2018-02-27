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
    private var startingTime = Date()
    private var currentTime = Date()
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
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
        
        print(self.startingTime)
    }
    
    
    @IBAction func onFinishPressed(_ sender: Any) 
    {
        // TODO: Add session record before dismissing
        dismiss(animated: true, completion: nil)
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
            self.dismiss(animated: true, completion: nil)
        })
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
