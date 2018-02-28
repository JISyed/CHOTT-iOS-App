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
        
        ChottDataService.loadCurrentSessions(of: self.currentProject!)
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        self.imgViewCategory.image = ChottCategory.icon(of: self.currentCategory)
        self.lblCategory.text = ChottCategory.name(of: self.currentCategory)
        self.lblProjectName.text = self.currentProject!.name
        self.viewHistoryBanner.backgroundColor = ChottCategory.regularColor(of: self.currentCategory)
        
        self.tableSessions.reloadData()
    }
    
    
    func setup(with project: ChottProjectData?)
    {
        self.currentProject = project
        self.currentCategory = ChottCategory(rawValue: Int(self.currentProject!.categoryId))!
    }
    
    
    @IBAction func onBackBtnPressed(_ sender: Any) 
    {
        dismissLaterally()
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
        return ChottDataService.currentSessions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableCell.ID) as? HistoryTableCell else {return UITableViewCell()}
        
        let session = ChottDataService.currentSessions[indexPath.row]
        
        cell.setupCell(withSession: session)
        
        return cell
    }
    
    
    // Allows table cells to be editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool 
    {
        return true
    }
    
    
    // No edit icons (unswiped)
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle 
    {
        return UITableViewCellEditingStyle.none
    }
    
    
    // Add swipe actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? 
    {
        let session = ChottDataService.currentSessions[indexPath.row]
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            
            let alert = UIAlertController(title: "Delete Session?", message: "Are you sure you want to delete this session of '\(self.currentProject!.name!)'? This cannot be undone!", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in                
                ChottDataService.deleteSession(session, atIndex: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic) // automatic animation
            })
            
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deleteAction]
    }
    
    
}

