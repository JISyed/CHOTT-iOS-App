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
    
    private var currentCategory: ChottCategory?
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        guard let category = currentCategory else {return}
        let liteColor = ChottCategory.liteColor(of: category)
        
        self.imgViewCategory.image = ChottCategory.icon(of: category)
        self.imgViewCategory.tintColor = liteColor
        self.lblCategory.text = category.rawValue
        self.lblCategory.textColor = liteColor
        self.lblProjectName.text = "TODO: SET UP THE PROJECT NAME"
        self.lblProjectName.textColor = liteColor
        self.lblTimer.text = "0:00"
        self.lblTimer.textColor = liteColor
        self.viewColoredRing.backgroundColor = ChottCategory.regularColor(of: category)
        self.btnFinish.setTitleColor(liteColor, for: .normal)
        self.btnFinish.backgroundColor = ChottCategory.darkColor(of: category)
        
    }
    
    
    func setup(with category: ChottCategory?)
    {
        self.currentCategory = category
    }
    
    
    @IBAction func onFinishPressed(_ sender: Any) 
    {
        // TODO: Add session record before dismissing
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onRestartPressed(_ sender: Any) 
    {
        
    }
    
    @IBAction func onCancelPressed(_ sender: Any) 
    {
        // TODO: Confirm cancelling first
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
