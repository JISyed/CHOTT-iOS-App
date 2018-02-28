//
//  ProjectTableCell.swift
//  Chott
//
//  Created by Jibran Syed on 2/22/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class ProjectTableCell: UITableViewCell 
{
    static let ID = "ProjectCell"
    
    @IBOutlet weak var btnProjectName: UIButton!
    private var currentProject: ChottProjectData?
    weak var vcPresentingDelegate: ViewControllerPresenting?
    
    
    func setupCell(withProject project: ChottProjectData?)
    {
        self.currentProject = project
        self.btnProjectName.setTitle(project!.name, for: .normal)
    }
    
    
    
    @IBAction func onProjectNamePressed(_ sender: UIButton) 
    {
        guard let delegate = self.vcPresentingDelegate else { debugPrint("ERROR: Cannot find VC Presenting Delegate"); return }
        
        // First mark this project as recently tracked
        self.currentProject!.lastWorkedOn = Date()
        CoreDataService.saveContext()
        
        delegate.presentTimerViewController(withProject: self.currentProject)
    }
    
    @IBAction func onHistoryBtnPressed(_ sender: Any) 
    {
        guard let delegate = self.vcPresentingDelegate else { debugPrint("ERROR: Cannot find VC Presenting Delegate"); return }
        delegate.presentHistoryViewController(withProject: self.currentProject)
    }
    
    
}
