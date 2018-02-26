//
//  ViewControllerPresenting.swift
//  Chott
//
//  Created by Jibran Syed on 2/26/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

protocol ViewControllerPresenting: AnyObject
{
    func presentTimerViewController(withProject project: ChottProjectData?)
    
    func presentHistoryViewController(withProject project: ChottProjectData?)
}
