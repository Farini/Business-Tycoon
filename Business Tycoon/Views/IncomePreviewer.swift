//
//  IncomePreviewer.swift
//  Business Tycoon
//
//  Created by Farini on 11/7/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit

class IncomePreviewer: UIView {
    
    var bizShop:BizShop?
    
    func previewWith(bizShop:BizShop){
        self.bizShop = bizShop
        
        let lbl = UILabel()
        lbl.text = "try"
        let orig = CGPoint.zero
        
        addSubview(lbl)
        //self.setNeedsDisplay()
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    
    

}
