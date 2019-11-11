//
//  BusinessBrowser.swift
//  Business Tycoon
//
//  Created by Carlos Farini on 11/11/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit
import SceneKit

class BusinessBrowser: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ceo:CEO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Biz browser showing")
        
        let ceo = CEO(name: "Fari", cash:2000, bankCredit: 1000, tokens: 0, influence: 0, businesses: [])
        
        print("CEO: \(ceo)")
        
        self.ceo = ceo
    }
}

extension BusinessBrowser: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension BusinessBrowser: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.section), row: \(indexPath.row)")
    }
}
