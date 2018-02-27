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
    
    private var currentCategory: ChottCategory = .art  // Needed to avoid init()
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableProjects.delegate = self
        self.tableProjects.dataSource = self
        
        // Invoke the loading of data for projects of this category
        CoreDataService.context.reset()
        ChottDataService.loadCurrentProjects(from: self.currentCategory)
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        self.imgViewCategory.image = ChottCategory.icon(of: self.currentCategory)
        self.lblCategory.text = ChottCategory.name(of: self.currentCategory)
        self.viewCategoryBanner.backgroundColor = ChottCategory.regularColor(of: self.currentCategory)
        self.btnAdd.backgroundColor = ChottCategory.darkColor(of: self.currentCategory)
        
        self.tableProjects.reloadData()
    }
    
    
    
    func setup(with category: ChottCategory)
    {
        self.currentCategory = category
    }
    
    
    
    @IBAction func onBackBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onAddBtnPressed(_ sender: Any) 
    {
        guard let addProjectVC = storyboard?.instantiateViewController(withIdentifier: AddProjectViewController.STRYBRD_ID) as? AddProjectViewController else { debugPrint("ERROR: Could not get AddProjectVC!"); return}
        
        addProjectVC.setup(with: self.currentCategory)
        
        present(addProjectVC, animated: true, completion: nil)
    }
    
    
}


extension SelectProjectViewController: UITableViewDelegate
{
}

extension SelectProjectViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return ChottDataService.currentProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableCell.ID) as? ProjectTableCell else {return UITableViewCell()}
        
        let project = ChottDataService.currentProjects[indexPath.row]
        
        cell.vcPresentingDelegate = self
        cell.setupCell(withProject: project)
        
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
        let project = ChottDataService.currentProjects[indexPath.row]
        
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            //self.removeGoal(atIndexPath: indexPath)
            //self.fetchGoalsFromCoreData()   // Reload
            //tableView.deleteRows(at: [indexPath], with: .automatic) // automatic animation
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        
        let renameAction = UITableViewRowAction(style: .normal, title: "Rename") { (rowAction, indexPath) in
            let alert = UIAlertController(title: "Rename Project", message: "Provide a new name for '\(project.name!)'", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "New Project Name"
                textField.keyboardAppearance = .dark
            })
            
            let renameAction = UIAlertAction(title: "Rename", style: .destructive, handler: { (_) in                
                guard let newName = alert.textFields!.first!.text, newName != "" else
                {            
                    let alert = UIAlertController(title: "Project Not Renamed", message: "You forgot to provide a new name for '\(project.name!)'.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                ChottDataService.renameProject(project, with: newName)
                tableView.reloadRows(at: [indexPath], with: .automatic) // Reload this row only
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(renameAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
            
            tableView.reloadRows(at: [indexPath], with: .automatic) // Reload this row only
        }
        renameAction.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        
        
        return [deleteAction, renameAction]
    }
    
}



extension SelectProjectViewController: ViewControllerPresenting
{
    func presentTimerViewController(withProject project: ChottProjectData?) 
    {
        guard let timerVC = self.storyboard?.instantiateViewController(withIdentifier: ProjectTimerViewController.STRYBRD_ID) as? ProjectTimerViewController else { debugPrint("ERROR: Could not get TimerVC!"); return }
        
        timerVC.setup(with: project!)
        present(timerVC, animated: true, completion: nil)
    }
    
    func presentHistoryViewController(withProject project: ChottProjectData?) 
    {
        guard let historyVC = self.storyboard?.instantiateViewController(withIdentifier: ProjectHistoryViewController.STRYBRD_ID) as? ProjectHistoryViewController else { debugPrint("ERROR: Could not get TimerVC!"); return }
        
        historyVC.setup(with: project!)
        present(historyVC, animated: true, completion: nil)
    }
    
    
}

