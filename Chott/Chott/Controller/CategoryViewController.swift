//
//  CategoryViewController.swift
//  Chott
//
//  Created by Jibran Syed on 2/20/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController 
{
    static let STRYBRD_ID = "CategoryVC"
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    @IBAction func onCategoryBtnPressed(_ sender: UIButton) 
    {
        var chosenCategory: ChottCategory? = nil
        
        switch sender.tag 
        {
        case 1:
            chosenCategory = .code
            break
        case 2:
            chosenCategory = .art
            break
        case 3:
            chosenCategory = .music
            break
        case 4:
            chosenCategory = .writing
            break
        default:
            debugPrint("ERROR: Category button tag is invalid. Should be between 1-4.")
            break
        }
        
        guard let projectVC = storyboard?.instantiateViewController(withIdentifier: SelectProjectViewController.STRYBRD_ID) as? SelectProjectViewController else {return}
        
        projectVC.setup(with: chosenCategory)
        
        present(projectVC, animated: true, completion: nil)
    }
    
    
    
}

