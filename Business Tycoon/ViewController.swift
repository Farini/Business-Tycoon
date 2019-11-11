//
//  ViewController.swift
//  Business Tycoon
//
//  Created by Farini on 11/5/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    
    @IBOutlet weak var incomeStmtView: IncomeStatementView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let scene = SCNScene(named: "cafe.scn") else{
            print("Could not load file")
            return
        }
        
        sceneView.scene = scene
        
        // Add the buy button
        let buttonItem = UIBarButtonItem(title: "Buy", style: .done, target: self, action: #selector(rateApp))
        navigationItem.rightBarButtonItem = buttonItem
        
        
        // Model
//        print("Shop model")
//
//        let shops = Bundle.main.decode([BizShop].self, from: "Businesses.json")
//        for shop in shops{
//            print("\n ---")
//            print("\(shop.name) INCOME STATEMENT")
//            let netInc = shop.income.netIncome()
//            print("\(shop.name) Net Income: \(netInc)")
//        }
//
//        let shop = shops.first!
//
//        incomeStmtView.previewWith(bizShop: shop)
    }
    
    @objc func rateApp(){
        print("Button Action. Buy")
    }


}

