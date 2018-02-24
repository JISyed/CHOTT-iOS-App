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
    
    
    @objc
    private func onTap(_ recognizer: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    
    @IBAction func onCancelBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddBtnPressed(_ sender: Any) 
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onAddAndTrackBtnPressed(_ sender: Any) 
    {
        guard let timerVC = self.storyboard?.instantiateViewController(withIdentifier: ProjectTimerViewController.STRYBRD_ID) as? ProjectTimerViewController else {return}
        
        guard let presentedVC = presentedViewController else { debugPrint("ERROR: Could not dismiss this VC!"); return }
        presentedVC.dismiss(animated: false) 
        {
            // Setup TimerVC
            
            self.present(timerVC, animated: false, completion: nil)
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
