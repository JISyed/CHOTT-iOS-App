//
//  ChottCurrentSessionData.swift
//  Chott
//
//  Created by Jibran Syed on 2/28/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import Foundation

/// Used to save the current timed session if the app quits
struct ChottCurrentSessionData
{
    let currentProjectId: UUID
    let currentStartTime: Date
}
