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
    
    
    
    
    /// Prints a date like: September 14, 2015
    static func getDateString(for date: Date) -> String
    {
        return DateUtility.instance.dateFormatter.string(from: date)
    }
    
    /// Prints a time like: 3:09 PM
    static func getTimeString(for date: Date) -> String
    {
        return DateUtility.instance.timeFormatter.string(from: date)
    }
    
    /// Prints a time range like: 3:09 - 6:11 PM
    static func getTimeRangeString(from start: Date, to end: Date) -> String
    {
        return DateUtility.instance.timeRangeFormatter.string(from: start, to: end)
    }
    
    /// Prints the amount of time elapsed between the two given dates. Can end in "sec", "min", "hr", or "X hr, Y min"
    static func getTimeIntervalString(from start: Date, to end: Date) -> String
    {
        let timeInterval = Int(end.timeIntervalSince(start))
        
        if timeInterval > 59
        {
            if timeInterval > 3599
            {
                let remainingMinutes = (timeInterval / 60) % 60
                
                // Return in hours
                if remainingMinutes == 0
                {
                    return "\(timeInterval / 3600) hr"
                }
                else
                {
                    return "\(timeInterval / 3600) hr, \(remainingMinutes) min"
                }
                
            }
            
            // Return in minutes
            return "\(timeInterval / 60) min"
        }
        
        // Return in seconds
        return "\(timeInterval) sec"
    }
    
    
    
    
}
