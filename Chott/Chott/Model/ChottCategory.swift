//
//  ChottCategory.swift
//  Chott
//
//  Created by Jibran Syed on 2/23/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit // For UIColor


enum ChottCategory: Int
{
    case code = 1
    case art = 2
    case music = 3
    case writing = 4
    
    
    
    // Enum Methods
    
    private static let codeName = "Code"
    private static let artName = "Art"
    private static let musicName = "Music"
    private static let writingName = "Writing"
    
    
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
            return AppImages.iconCode
        case .art:
            return AppImages.iconArt
        case .music:
            return AppImages.iconMusic
        case .writing:
            return AppImages.iconWriting
        }
    }
    
    static func name(of category: ChottCategory) -> String
    {
        switch category
        {
        case .code:
            return codeName
        case .art:
            return artName
        case .music:
            return musicName
        case .writing:
            return writingName
        }
    }
    
}
