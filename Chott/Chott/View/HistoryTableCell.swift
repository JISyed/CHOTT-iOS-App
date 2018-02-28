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
        self.lblDate.text = DateUtility.getDateString(for: session.startTime!)
        self.lblStartAndEndTimes.text = DateUtility.getTimeRangeString(from: session.startTime!, to: session.endTime!)
        self.lblDuration.text = DateUtility.getTimeIntervalString(from: session.startTime!, to: session.endTime!)
        
        // Change shade of duration text depending on length of time (1 hour+ will be white)
        if self.lblDuration.text!.contains("min") 
        {
            if self.lblDuration.text!.contains("hr") 
            {
                self.lblDuration.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                self.lblDuration.textColor = #colorLiteral(red: 0.8660572652, green: 0.8660572652, blue: 0.8660572652, alpha: 1)
            }
        }
        if self.lblDuration.text!.contains("sec") 
        {
            self.lblDuration.textColor = #colorLiteral(red: 0.7021409648, green: 0.7021409648, blue: 0.7021409648, alpha: 1)
        }
    }
    
    
    
}
