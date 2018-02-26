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
    
    
    func setupCell(withProject project: ChottProjectData?)
    {
        self.currentProject = project
        
        self.btnProjectName.setTitle(project!.name, for: .normal)
    }
    
    
    
    @IBAction func onProjectNamePressed(_ sender: UIButton) 
    {
        
    }
    
    @IBAction func onHistoryBtnPressed(_ sender: Any) 
    {
        
    }
    
    
}
