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
    var bizIndex:Int = 0
    
//    var rowStrings:[String] = []
//    var rowValues:[Double] = []
    
    var finantialLines:[FinantialLine] = []
    var incomeStmtLines:[FinantialLine] = []
    
    var pairs:[String:Double] = [:]
    
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
        
        selectedBiz = businesses.first
        forSale = businesses
        
        if let b = selectedBiz { display(biz: b) }
        
        // Table
        tableView.register(BizStatementCell.self, forCellReuseIdentifier: "id1")
        tableView.separatorStyle = .none
//        let sty = tableView.separatorStyle
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
        
        // Table
        self.finantialLines = biz.finantials.balanceSheet.lines()
        self.incomeStmtLines = biz.finantials.incomeStatement.lines()
        
        tableView.reloadData()
    }
    
    @objc func buyShop(){
        
        
        guard let business = selectedBiz else { return }
        print("Wants to buy Biz \(business.name): \(business.finantials.incomeStatement.netIncome())")
        
        // Describe balance sheet
        print("\n ----- \n * \(business.name.uppercased()) BALANCE SHEET")
        business.finantials.balanceSheet.describe()
        
    }
    
    @IBAction func goToNext(_ sender: UIButton) {
        let nxtIdx = bizIndex + 1
        if forSale.count - 1 >= nxtIdx{
            let nb = forSale[nxtIdx]
            display(biz: nb)
            bizIndex = nxtIdx
            
        }else{
            if let nb = forSale.first{
                display(biz: nb)
                bizIndex = 0
            }else{
                print("something went wrong")
            }
        }
    }
    
}

extension BusinessBrowser: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Income Statement"
        case 1: return "Balance Sheet"
        default: return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return incomeStmtLines.count
        case 1: return finantialLines.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "id1", for: indexPath) as! BizStatementCell
        
        if indexPath.section == 0{
            let stmtLine = incomeStmtLines[indexPath.row]
            cell.prepareLine(line: stmtLine)
            // cell.prepText(left: stmtLine.leftHandle, right: stmtLine.rightHandle)
        }else if indexPath.section == 1{
            let finLine = finantialLines[indexPath.row]
            cell.prepareLine(line: finLine)
            // cell.prepText(left: finLine.leftHandle, right: finLine.rightHandle)
        }
    
        return cell
    }
}

extension BusinessBrowser: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.section), row: \(indexPath.row)")
    }
}
