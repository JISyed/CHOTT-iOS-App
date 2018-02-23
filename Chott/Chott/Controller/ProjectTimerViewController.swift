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
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func onFinishPressed(_ sender: Any) 
    {
        
    }
    
    @IBAction func onRestartPressed(_ sender: Any) 
    {
        
    }
    
    @IBAction func onCancelPressed(_ sender: Any) 
    {
        
    }
    
    
    
}
