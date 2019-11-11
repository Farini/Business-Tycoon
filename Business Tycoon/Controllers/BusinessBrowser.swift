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
    
    var forSale:[Business] = []
    var selectedBiz:Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Biz browser showing")
        
        // Data
        let ceo = CEO(name: "Fari", cash: 5000, credit: 5000, tokens: 0, influence: 0, businesses: [])
        print("CEO: \(ceo)")
        self.ceo = ceo
        
        // Interface
        // Scene
        
        /*
        guard let scene = SCNScene(named: "cafe.scn") else{
            print("Could not load file")
            return
        }
        
        sceneView.scene = scene
        */
        
        // Add the buy button
        let buttonItem = UIBarButtonItem(title: "Buy", style: .done, target: self, action: #selector(buyShop))
        navigationItem.rightBarButtonItem = buttonItem
        
        // Model
        print("Shop model")
        
        let businesses = Bundle.main.decode([Business].self, from: "ForSale.json")
        for business in businesses{
            print("Biz: \(business.name)")
            print("3D: \(business.model)")
        }
        selectedBiz = businesses.first
        forSale = businesses
        
        print("CEO has \(ceo.cash)")
        // print("Shop income: \(selectedBiz?.finantials.incomeStatement.netIncome() ?? 0)")
    }
    
    func layoutCurrentShop(){
        
//        guard let shop = selectedShop else { return }
//
//        print("Laying out current shop: \(shop.name)")
//        print("Accounting should be done here, then update tableview")
        
        
    }
    
    @objc func buyShop(){
        
        print("Wants to buy shop")
        guard let business = selectedBiz else { return }
        
        print("Biz \(business.name): \(business.finantials.incomeStatement.netIncome())")
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
