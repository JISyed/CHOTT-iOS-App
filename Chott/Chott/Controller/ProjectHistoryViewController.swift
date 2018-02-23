//
//  ProjectHistoryViewController.swift
//  Chott
//
//  Created by Jibran Syed on 2/22/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class ProjectHistoryViewController: UIViewController 
{
    static let STRYBRD_ID = "HistoryVC"
    
    @IBOutlet weak var imgViewCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblProjectName: UILabel!
    @IBOutlet weak var viewHistoryBanner: UIView!
    @IBOutlet weak var tableSessions: UITableView!
    
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableSessions.delegate = self
    }    
    
    
    @IBAction func onBackBtnPressed(_ sender: Any) 
    {
        
    }
    
    
}


extension ProjectHistoryViewController: UITableViewDelegate
{
}

extension ProjectHistoryViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        // TODO: Number of Sessions for this Project
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        // TODO: A HistoryTableCell
        return UITableViewCell()
    }
    
    
}

