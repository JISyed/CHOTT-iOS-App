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
    
    override func viewDidAppear(_ animated: Bool) 
    {
        super.viewDidAppear(animated)
        
        print(ChottDataService.isCurrentlyTimingSession())
    }
    
    
    @IBAction func onCategoryBtnPressed(_ sender: UIButton) 
    {        
        guard let selectProjectVC = storyboard?.instantiateViewController(withIdentifier: SelectProjectViewController.STRYBRD_ID) as? SelectProjectViewController else { debugPrint("ERROR: Could not get SelectProjectVC!"); return }
        
        // Using button tags between 1 to 4 to represent different catagories. See ChottCategories.swift
        let selectedCategory = ChottCategory(rawValue: sender.tag)!
        selectProjectVC.setup(with: selectedCategory)
        
        
        present(selectProjectVC, animated: true, completion: nil)
    }
    
    
    
}

