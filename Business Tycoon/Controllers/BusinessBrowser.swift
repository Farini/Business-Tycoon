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
    
    
    @IBOutlet weak var sceneView: SCNView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var ceo:CEO?
    
    var forSale:[Business] = []
    var selectedBiz:Business?
    
    var rowStrings:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Biz browser showing")
        
        // Data
        let ceo = CEO(name: "Fari", cash: 5000, credit: 5000, tokens: 0, influence: 0, businesses: [])
        print("CEO: \(ceo)")
        self.ceo = ceo
        print("CEO has \(ceo.cash)")
        
        // Interface
        
        // Add the buy button
        let buttonItem = UIBarButtonItem(title: "Buy", style: .done, target: self, action: #selector(buyShop))
        navigationItem.rightBarButtonItem = buttonItem
        
        // Model
        // print("Shop model")
        
        let businesses = Bundle.main.decode([Business].self, from: "ForSale.json")
        for _ in businesses{
            // print("Biz: \(business.name)")
            // print("3D: \(business.model)")
        }
        selectedBiz = businesses.first
        forSale = businesses
        
        if let b = selectedBiz { display(biz: b) }
        
        // Table
        rowStrings.append("Carlos")
        rowStrings.append("test")
        rowStrings.append("test \n another \n line")
        rowStrings.append("test")
        rowStrings.append("test")
        
        tableView.register(BizStatementCell.self, forCellReuseIdentifier: "id1")
        tableView.reloadData()
        
    }
    
    func display(biz:Business){
        
        print("Showing Biz \(biz.name)")
        
        // Scene
        guard let scene = SCNScene(named: "cafe.scn") else{
            print("Could not load file")
            return
        }
        print("Showing model")
        sceneView.scene = scene
        
    }
    
    @objc func buyShop(){
        
        print("Wants to buy shop")
        guard let business = selectedBiz else { return }
        
        print("Biz \(business.name): \(business.finantials.incomeStatement.netIncome())")
        
        // Describe balance sheet
        business.finantials.balanceSheet.describe()
    }
}

extension BusinessBrowser: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowStrings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "id1", for: indexPath) as! BizStatementCell
        // cell.textLabel?.text = rowStrings[indexPath.row]
        // cell.textLabel?.numberOfLines = 0
        cell.prepText(left: "Definition", right: rowStrings[indexPath.row])
        return cell
    }
}

extension BusinessBrowser: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.section), row: \(indexPath.row)")
    }
}
