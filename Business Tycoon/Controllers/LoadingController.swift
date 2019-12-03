//
//  LoadingController.swift
//  Business Tycoon
//
//  Created by Farini on 12/3/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    
    var ceo:CEO?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityView.startAnimating()

        // Do any additional setup after loading the view.
        let playerDB = PlayerDB.shared
        
        if let database:Database = playerDB.getLocalData(){
            // we got a database
            print("Database started file: \(database)")
        }else{
            // no database. start here
            print("Database not started. Start new ?")
            let newCEO = CEO(name: "Farini")
            print("CEO created \(newCEO.name)")
            
            self.loaded(ceo: newCEO)
        }
    }
    
    func loaded(ceo:CEO){
        
        print("Loaded CEO \(ceo.name)")
        self.ceo = ceo
        
        
    }
    
    @IBAction func goToOverview(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toOverview", sender: sender)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Segueing...")
        
        if let navControl = segue.destination as? UINavigationController{
            
            print("Nav View Controllers count \(navControl.viewControllers.count)")
            
            self.activityView.stopAnimating()
            
            if let controller = navControl.topViewController as? CEOOverviewController{
                
                print("Top")
                
                guard let ceo = ceo else{
                    print("No CEO. Cannot perform this segue")
                    return
                }
                
                controller.ceo = ceo
                
            }
        }
    }
}
