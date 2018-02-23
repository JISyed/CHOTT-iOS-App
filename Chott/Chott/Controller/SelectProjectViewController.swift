//
//  SelectProjectViewController.swift
//  Chott
//
//  Created by Jibran Syed on 2/22/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class SelectProjectViewController: UIViewController 
{
    static let STRYBRD_ID = "SelectProjectVC"
    
    @IBOutlet weak var imgViewCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewCategoryBanner: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var tableProjects: UITableView!
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableProjects.delegate = self
    }
    
    
    @IBAction func onBackBtnPressed(_ sender: Any) 
    {
        
    }
    
    
    @IBAction func onAddBtnPressed(_ sender: Any) 
    {
        
    }
    
    
}


extension SelectProjectViewController: UITableViewDelegate
{
}

extension SelectProjectViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        // TODO: Number of projects
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        // TODO: A ProjectTableCell
        return UITableViewCell()
    }
    
    
}


