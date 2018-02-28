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
    
    private var currentCategory: ChottCategory = .art // Needed to avoid init()
    
    
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
        
        self.imgViewCategory.image = ChottCategory.icon(of: self.currentCategory)
        self.lblCategory.text = ChottCategory.name(of: self.currentCategory)
        self.viewCategoryBanner.backgroundColor = ChottCategory.regularColor(of: self.currentCategory)
    }
    
    
    func setup(with category: ChottCategory)
    {
        self.currentCategory = category
    }
    
    
    @objc
    private func onTap(_ recognizer: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    
    /// Returns true if project was successfully added
    private func addNewProject() -> ChottProjectData?
    {
        // Make sure text field isn't empty
        guard let newName = self.txtFieldNewName.text, newName != "" else
        {            
            let alert = UIAlertController(title: "Project Not Added", message: "You need to provide a name first.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
            
            return nil
        }
        
        // Add project
        return ChottDataService.addProject(withName: newName, andCategory: self.currentCategory)
    }
    
    
    @IBAction func onCancelBtnPressed(_ sender: Any) 
    {
        dismissLaterally()
    }
    
    @IBAction func onAddBtnPressed(_ sender: Any) 
    {
        guard (self.addNewProject() != nil) else { return }
        
        dismissLaterally()
    }
    
    @IBAction func onAddAndTrackBtnPressed(_ sender: Any) 
    {
        guard let newProject = self.addNewProject() else { return }
        
        guard let timerVC = self.storyboard?.instantiateViewController(withIdentifier: ProjectTimerViewController.STRYBRD_ID) as? ProjectTimerViewController else { debugPrint("ERROR: Could not get TimerVC!"); return }
        
        guard let previousVC = presentingViewController else { debugPrint("ERROR: Could not get previous VC!"); return }
        
        self.dismissLaterally { 
            timerVC.setup(withProject: newProject, andStartTime: Date())
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
