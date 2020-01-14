//
//  BusinessBrowser.swift
//  Business Tycoon
//
//  Created by Carlos Farini on 11/11/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit
import SceneKit
import SwiftUI

class BusinessBrowser: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblBizName: UILabel!
    @IBOutlet weak var lblBizCost: UILabel!
    
    var ceo:CEO?
    
    var forSale:[Business] = []
    var selectedBiz:Business?
    var bizIndex:Int = 0
    
    var finantialLines:[FinantialLine] = []
    var incomeStmtLines:[FinantialLine] = []
    
    var pairs:[String:Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Biz browser showing")
        
        // Data (CEO)
        
        if let ceo = self.ceo{
            
            print("CEO was already here \(ceo.name) with $ \(ceo.cash)")
            
        }else{
            
            let ceo = CEO(name: "Farini")
            
            // CEO(name: "Fari", cash: 5000, credit: 5000, tokens: 0, influence: 0, businesses: [])
            print("CEO: \(ceo)")
            self.ceo = ceo
            print("CEO has \(ceo.cash)")
        }
        
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
    }
    
    func display(biz:Business){
        
        print("Showing Biz \(biz.name)")
        
        // Scene
        let scene = BizScene()
        scene.addSceneModel(name: biz.model)
        sceneView.scene = scene
        sceneView.isUserInteractionEnabled = true
        sceneView.allowsCameraControl = true
        
        // Labels
        lblBizName.text = biz.name
        
        let arbitrary = biz.finantials.incomeStatement.netIncome() * 100
        lblBizCost.text = "$ \(Int(arbitrary))"
        
        // Table
        self.finantialLines = biz.finantials.balanceSheet.lines()
        self.incomeStmtLines = biz.finantials.incomeStatement.lines()
        
        tableView.reloadData()
    }
    
    @objc func buyShop(){
        
        
        guard let business = selectedBiz, let ceo = ceo else { return }
        
        
        // PPE
//        let ppe = PPEItem(name: "Espresso Machine", valueAtPurchase: 2000.0, depreciationRate: 0.01, purchaseDate: Date())
//
//        let age = ppe.age
//        let ageInWeeks = ppe.currentAgeInWeeks()
//        let currentValue = ppe.currentValue
//        let accDepr = ppe.accumulatedDepreciation()
//
//        print("Rundown of \(ppe.name)...")
//        print("Age \(age), weeks:\(ageInWeeks)")
//        print("Current Value: \(currentValue), accum depr \(accDepr)")
//        print("--- \n")

        
        // Describe balance sheet
        print("\n ----- \n * \(business.name.uppercased()) BALANCE SHEET")
        business.finantials.balanceSheet.describe()
        
        print("\n\n")
        print("Wants to Purchase Biz \(business.name): Biz Income: \(business.finantials.incomeStatement.netIncome())")
        
        let bizValue:Double = business.finantials.balanceSheet.purchaseValue()
        let cashValue:Double = ceo.cash
        
        print("\n_________\n")
        
        if cashValue >= bizValue{
            print("Enough money to purchase biz")
        }else{
            let loanSize:Double = bizValue - cashValue
            print("CEO \(ceo.name) does not have enough money. Want a loan of \(loanSize) ?")
            // Ask (for now take)
            completePurchase()
        }
        
    }
    
    func completePurchase(){
        
        guard let business = selectedBiz, let ceo = ceo else { return }
        
        let bizValue:Double = business.finantials.balanceSheet.purchaseValue()
        let cashValue:Double = ceo.cash
        let loanSize:Double = bizValue - cashValue
        
        if loanSize > 0{
            
            print("Taking loan: \(loanSize)")
            var accountsPayable = business.finantials.balanceSheet.accountsPayable
            accountsPayable += loanSize
            
            print("Accounts Payable -(b4): \(business.finantials.balanceSheet.accountsPayable)")
            print("Accounts Payable after: \(accountsPayable)")
            
            // Add to accounts payable
            var balance:BalanceSheet = business.finantials.balanceSheet
            balance.accountsPayable = accountsPayable
            
            // Take from shareholders equity?
            balance.capitalStock -= accountsPayable
            
            balance.describe()
            
        }
        
        self.performSegue(withIdentifier: "buybiz", sender: self)
        
    }
    
    @IBSegueAction func addSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        
        // Swift UI View
        let ctrlView = BizControl(business: Business.example).environmentObject(BusinessActions())
        return UIHostingController(coder: coder, rootView: ctrlView)
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
    
    
    // MARK: - Navigation
    
    
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
