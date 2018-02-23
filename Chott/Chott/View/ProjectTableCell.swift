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
    
    
    override func awakeFromNib() 
    {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) 
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        
    }
    
    
    @IBAction func onProjectNamePressed(_ sender: UIButton) 
    {
        
    }
    
    @IBAction func onHistoryBtnPressed(_ sender: Any) 
    {
        
    }
    
    
}
