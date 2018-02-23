//
//  ChottCategory.swift
//  Chott
//
//  Created by Jibran Syed on 2/23/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit // For UIColor


enum ChottCategory: String
{
    case code = "Code"
    case art = "Art"
    case music = "Music"
    case writing = "Writing"
    
    
    
    // Enum Methods
    
    static func regularColor(of category: ChottCategory) -> UIColor
    {
        switch category
        {
        case .code:
            return AppColors.categoryCodeRegular
        case .art:
            return AppColors.categoryArtRegular
        case .music:
            return AppColors.categoryMusicRegular
        case .writing:
            return AppColors.categoryWritingRegular
        }
    }
    
    static func liteColor(of category: ChottCategory) -> UIColor
    {
        switch category
        {
        case .code:
            return AppColors.categoryCodeLite
        case .art:
            return AppColors.categoryArtLite
        case .music:
            return AppColors.categoryMusicLite
        case .writing:
            return AppColors.categoryWritingLite
        }
    }
    
    static func darkColor(of category: ChottCategory) -> UIColor
    {
        switch category
        {
        case .code:
            return AppColors.categoryCodeDark
        case .art:
            return AppColors.categoryArtDark
        case .music:
            return AppColors.categoryMusicDark
        case .writing:
            return AppColors.categoryWritingDark
        }
    }
    
    static func icon(of category: ChottCategory) -> UIImage
    {
        switch category
        {
        case .code:
            return UIImage(named: "ico_code")!
        case .art:
            return UIImage(named: "ico_art")!
        case .music:
            return UIImage(named: "ico_music")!
        case .writing:
            return UIImage(named: "ico_writing")!
        }
    }
    
}
