//
//  DateUtilityTests.swift
//  ChottTests
//
//  Created by Jibran Syed on 2/27/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import XCTest
@testable import Chott

class DateUtilityTests: XCTestCase 
{
    
    override func setUp() 
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() 
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        
        super.tearDown()
    }
    
    
    
    func testDateAndTimeFormatting()
    {
        print(DateUtility.getDateString(for: Date()))
        print(DateUtility.getTimeString(for: Date()))
        print(DateUtility.getTimeRangeString(from: Date(timeIntervalSinceNow: -19000.0), to: Date()))
        print(DateUtility.getTimeRangeString(from: Date(timeIntervalSinceNow: -9000.0), to: Date()))
        
        print(DateUtility.getTimeIntervalString(from: Date(timeIntervalSinceNow: -30.0), to: Date()))
        print(DateUtility.getTimeIntervalString(from: Date(timeIntervalSinceNow: -61.0), to: Date()))
        print(DateUtility.getTimeIntervalString(from: Date(timeIntervalSinceNow: -191.0), to: Date()))
        print(DateUtility.getTimeIntervalString(from: Date(timeIntervalSinceNow: -3661.0), to: Date()))
        print(DateUtility.getTimeIntervalString(from: Date(timeIntervalSinceNow: -9000.0), to: Date()))
        
        print(DateUtility.getTimerString(from: Date(timeIntervalSinceNow: -30.0), to: Date()))
        print(DateUtility.getTimerString(from: Date(timeIntervalSinceNow: -61.0), to: Date()))
        print(DateUtility.getTimerString(from: Date(timeIntervalSinceNow: -191.0), to: Date()))
        print(DateUtility.getTimerString(from: Date(timeIntervalSinceNow: -3661.0), to: Date()))
        print(DateUtility.getTimerString(from: Date(timeIntervalSinceNow: -9000.0), to: Date()))
    }
    
    
}
