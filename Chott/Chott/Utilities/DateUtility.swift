//
//  DateUtility.swift
//  Chott
//
//  Created by Jibran Syed on 2/27/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import Foundation

class DateUtility
{
    static let instance = DateUtility()
    private init()
    {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .long
        self.dateFormatter.timeStyle = .none
        self.dateFormatter.locale = Locale.current
        
        self.timeFormatter = DateFormatter()
        self.timeFormatter.dateStyle = .none
        self.timeFormatter.timeStyle = .short
        self.timeFormatter.locale = Locale.current
        
        self.timeRangeFormatter = DateIntervalFormatter()
        self.timeRangeFormatter.dateStyle = .none
        self.timeRangeFormatter.timeStyle = .short
        self.timeRangeFormatter.locale = Locale.current
    }
    
    private let dateFormatter: DateFormatter
    private let timeFormatter: DateFormatter
    private let timeRangeFormatter: DateIntervalFormatter
    
    
    static func getDateString(for date: Date) -> String
    {
        return DateUtility.instance.dateFormatter.string(from: date)
    }
    
    static func getTimeString(for date: Date) -> String
    {
        return DateUtility.instance.timeFormatter.string(from: date)
    }
    
    static func getTimeRangeString(from start: Date, to end: Date) -> String
    {
        return DateUtility.instance.timeRangeFormatter.string(from: start, to: end)
    }
    
    static func getTimeIntervalString(from start: Date, to end: Date) -> String
    {
        let timeInterval = Int(end.timeIntervalSince(start))
        
        if timeInterval > 59
        {
            if timeInterval > 3599
            {
                let remainingMinutes = (timeInterval / 60) % 60
                
                if remainingMinutes == 0
                {
                    return "\(timeInterval / 3600) hr"
                }
                else
                {
                    return "\(timeInterval / 3600) hr, \(remainingMinutes) min"
                }
                
            }
            
            return "\(timeInterval / 60) min"
        }
        
        // Return in seconds
        return "\(timeInterval) sec"
    }
    
}
