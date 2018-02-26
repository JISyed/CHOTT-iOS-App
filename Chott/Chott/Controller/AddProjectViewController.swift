//
//  AddProjectViewController.swift
//  Chott
//
//  Created by Jibran Syed on 2/21/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController 
{
    static let STRYBRD_ID = "AddProjectVC"
    
    @IBOutlet weak var txtFieldNewName: UITextField!
    @IBOutlet weak var imgViewCategory: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewCategoryBanner: UIView!
    
    private var currentCategory: ChottCategory?
    
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.txtFieldNewName.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        tap.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) 
    {
        super.viewWillAppear(animated)
        
        guard let category = currentCategory else {return}
        self.imgViewCategory.image = ChottCategory.icon(of: category)
        self.lblCategory.text = ChottCategory.name(of: category)
        self.viewCategoryBanner.backgroundColor = ChottCategory.regularColor(of: category)
    }
    
    
    func setup(with category: ChottCategory?)
    {
        self.currentCategory = category
    }
    
    
    @objc
    private func onTap(_ recognizer: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    
    /// Returns true if project was successfully added
    private func addNewProject() -> Bool
    {
        // TODO: Make sure text field isn't empty
        guard let newName = self.txtFieldNewName.text, newName != "" else
        {
            // TODO: Refactor this to show a prompt saying you need a name!
            print("No name provided. Will not add project")
            return false
        }
        
        // TODO: Make sure given name doesn't already exist
        
        
        // TODO: Add project
        ChottDataService.addProject(withName: newName, andCategory: self.currentCategory!)
        
        return true
    }
    
    
    @IBAction func onCancelBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddBtnPressed(_ sender: Any) 
    {
        guard self.addNewProject() else { return }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddAndTrackBtnPressed(_ sender: Any) 
    {
        //guard self.addNewProject() else { return }
        
        guard let timerVC = self.storyboard?.instantiateViewController(withIdentifier: ProjectTimerViewController.STRYBRD_ID) as? ProjectTimerViewController else { debugPrint("ERROR: Could not get TimerVC!"); return }
        
        guard let previousVC = presentingViewController else { debugPrint("ERROR: Could not get previous VC!"); return }
        self.dismiss(animated: true) 
        {
            timerVC.setup(with: self.currentCategory)
            
            previousVC.present(timerVC, animated: true, completion: nil)
        }
    }
    
    
}



extension AddProjectViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool 
    {
        return textField.resignFirstResponder()
    }
}



extension AddProjectViewController: UIGestureRecognizerDelegate
{
}
