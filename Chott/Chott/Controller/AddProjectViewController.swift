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
    
    
    
    private func addNewProject()
    {
        // TODO: Make sure text field isn't empty
        
        // TODO: Make sure given name doens't already exist
        
        // TODO: Add project
    }
    
    
    @IBAction func onCancelBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddBtnPressed(_ sender: Any) 
    {
        self.addNewProject()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddAndTrackBtnPressed(_ sender: Any) 
    {
        self.addNewProject()
        
        guard let timerVC = self.storyboard?.instantiateViewController(withIdentifier: ProjectTimerViewController.STRYBRD_ID) as? ProjectTimerViewController else { debugPrint("ERROR: Could not get TimerVC!"); return }
        
        guard let previousVC = presentingViewController else { debugPrint("ERROR: Could not get previous VC!"); return }
        self.dismiss(animated: true) 
        {
            // Setup TimerVC
            
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
