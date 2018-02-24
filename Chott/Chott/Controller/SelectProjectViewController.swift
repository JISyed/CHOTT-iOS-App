//
//  SelectProjectViewController.swift
//  Chott
//
//  Created by Jibran Syed on 2/22/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class SelectProjectViewController: UIViewController 
{
    static let STRYBRD_ID = "SelectProjectVC"
    
    @IBOutlet weak var imgViewCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewCategoryBanner: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var tableProjects: UITableView!
    
    private var currentCategory: ChottCategory!
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableProjects.delegate = self
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        guard let category = currentCategory else {return}
        self.imgViewCategory.image = ChottCategory.icon(of: category)
        self.lblCategory.text = category.rawValue
        self.viewCategoryBanner.backgroundColor = ChottCategory.regularColor(of: category)
        self.btnAdd.backgroundColor = ChottCategory.darkColor(of: category)
    }
    
    
    
    func setup(with category: ChottCategory?)
    {
        self.currentCategory = category
    }
    
    
    
    @IBAction func onBackBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onAddBtnPressed(_ sender: Any) 
    {
        guard let addProjectVC = storyboard?.instantiateViewController(withIdentifier: AddProjectViewController.STRYBRD_ID) as? AddProjectViewController else {return}
        
        //addProjectVC.setup(with: chosenCategory)
        
        present(addProjectVC, animated: true, completion: nil)
    }
    
    
}


extension SelectProjectViewController: UITableViewDelegate
{
}

extension SelectProjectViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        // TODO: Number of projects
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        // TODO: A ProjectTableCell
        return UITableViewCell()
    }
    
    
}


