//
//  CircularView.swift
//  Chott
//
//  Created by Jibran Syed on 2/22/18.
//  Copyright © 2018 Jishenaz. All rights reserved.
//

import UIKit

@IBDesignable
class CircularView: UIView 
{
    override func awakeFromNib() 
    {
        super.awakeFromNib()
        
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() 
    {
        super.prepareForInterfaceBuilder()
        
        self.setupView()
    }
    
    override func layoutSubviews() 
    {
        super.layoutSubviews()
        
        self.setupView()
    }
    
    
    func setupView()
    {
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }
}
