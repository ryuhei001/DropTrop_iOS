//
//  File.swift
//  DropTrop
//
//  Created by 道添　竜平 on 2018/11/02.
//  Copyright © 2018 道添　竜平. All rights reserved.
//

import UIKit

class CustomButton:UIButton{
    var labelText = UILabel()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    
    
}
extension CustomButton{
    func customInit(){
        self.layer.cornerRadius = 5.0
        
    }
    
}
