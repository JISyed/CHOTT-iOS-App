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
    
    
    func setupCell(withSession session: ChottSessionData)
    {
        self.lblDate.text = session.endTime!.description
    }
    
    
    
}
