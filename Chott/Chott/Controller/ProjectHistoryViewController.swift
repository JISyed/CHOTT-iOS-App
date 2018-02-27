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
    
    private var currentCategory: ChottCategory = .art // Needed to avoid init()
    private var currentProject: ChottProjectData?
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableSessions.delegate = self
        self.tableSessions.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        self.imgViewCategory.image = ChottCategory.icon(of: self.currentCategory)
        self.lblCategory.text = ChottCategory.name(of: self.currentCategory)
        self.lblProjectName.text = self.currentProject!.name
        self.viewHistoryBanner.backgroundColor = ChottCategory.regularColor(of: self.currentCategory)
    }
    
    
    
    func setup(with project: ChottProjectData?)
    {
        self.currentProject = project
        self.currentCategory = ChottCategory(rawValue: Int(self.currentProject!.categoryId))!
    }
    
    
    
    @IBAction func onBackBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
}




extension ProjectHistoryViewController: UITableViewDelegate
{
}

extension ProjectHistoryViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int 
    {
        if ChottDataService.currentSessions.count == 0
        {
            let emptyTableLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            emptyTableLabel.text = "Track time for this project to see its history here."
            emptyTableLabel.textAlignment = .center
            emptyTableLabel.textColor = UIColor.white
            emptyTableLabel.numberOfLines = 0
            emptyTableLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title2)
            emptyTableLabel.sizeToFit()
            tableView.backgroundView = emptyTableLabel
            tableView.separatorStyle = .none
            
            return 1
        }
        
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        // TODO: Number of Sessions for this Project
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        // TODO: A HistoryTableCell
        return UITableViewCell()
    }
    
    
}

