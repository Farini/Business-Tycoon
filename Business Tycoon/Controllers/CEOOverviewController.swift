//
//  CEOOverviewController.swift
//  Business Tycoon
//
//  Created by Farini on 12/3/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit

class CEOOverviewController: UIViewController {
    
    /*
     ----------------------------------
     # CEO Overview
     
     + A List of businesses owned?
     + CEO Avatar (if any)
     + List of friends?
     
     ----------------------------------
     */
    
    var ceo:CEO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Overview View Controller View did load")
        
        guard let ceo = ceo else{
            print("No CEO on CEO Overview Controller")
            return
        }
        
        print("Overview CEO \(ceo.name)")
        
        let shopArray:[PPEItem] = Bundle.main.decode([PPEItem].self, from: "PPESample.json")
        for item in shopArray{
            print("Item: \(item.name)")
        }
        
    }
    
    @IBAction func shopForBusinesses(_ sender: UIButton) {
        // toBrowse
        performSegue(withIdentifier: "toBrowse", sender: self)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? BusinessBrowser{
            destination.ceo = self.ceo
        }
        
    }

}
