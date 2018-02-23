//
//  HistoryTableCell.swift
//  Chott
//
//  Created by Jibran Syed on 2/22/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class HistoryTableCell: UITableViewCell 
{
    static let ID = "HistoryCell"
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStartAndEndTimes: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    
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
    
    
    
}
