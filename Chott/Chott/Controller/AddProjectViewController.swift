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
