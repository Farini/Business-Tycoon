//  BizModel.swift
//  Business Tycoon: Created by Farini on 11/6/19.
//  Copyright © 2019 Farini. All rights reserved.

import Foundation

// MARK: Base Structure

struct CEO {
    
    var name:String
    var cash:Double
    var credit:Double
    var tokens:Int
    var influence:Int
    
    var businesses:[Business]
}

/*
struct BizShop:Codable{
    
    var name:String
    
    var income:IncomeStatement
    // var cashFlow:Cashflow
    // var balance:BalanceSheet
}
*/

struct Business:Codable{
    
    var name:String
    var model:String
    
    var finantials:Finantials
}
/*
struct Address{
    
    var streetNumber:Int
    var streetName:String
    var streetExtended:String
    var neighborhood:String
}
*/

// MARK: - Finantials

struct Finantials:Codable{
    
    // Current
    var incomeStatement:IncomeStatement
    var balanceSheet:BalanceSheet
    var cashflow:Cashflow
    
    // History
    // var histoIncome:[IncomeStatement] = []
    // var histoBalance:[BalanceSheet] = []
    // var histoCashflow:[Cashflow] = []
    
//    func searchPeriod(p:AccountingPeriod){
//
//    }
    
//    init?(dictionary:[String:Any]){
//
//    }
    
//    private enum CodingKeys:String, CodingKey{
//        case incomeStatement
//        case balanceSheet
//        case cashflow
//    }
    
    /*
     
     "cashflow":{
         "period":"W0",
         "netIncome":0.0,
         "accountsReceivable":0.0,
         "inventory":0.0,
         "prepaidExpenses":0.00,
         "accountsPayable":0.0,
         "purchases":0.0,
         "mortgage":0.0,
         "autoLoan":0.0,
         "ownersInvestment":15000.0,
         "netIncrease":0.0
     }
     
     */
    
    // ==== SEPARATOR
    
    
    /*
     ,
     "cashflow":{
         "period":"W0",
         "netIncome":0.0,
         "accountsReceivable":0.0,
         "inventory":0.0,
         "prepaidExpenses":0.00,
         "accountsPayable":0.0,
         "purchases":0.0,
         "mortgage":0.0,
         "autoLoan":0.0,
         "ownersInvestment":15000.0,
         "netIncrease":0.0
     }
     */
}

struct IncomeStatement:Codable{
    
    var period:String
    var revenue:Double
    var costOfSales:Double
    var advertising:Double
    var badDebtExpense:Double
    var bankCharges:Double
    var insurance:Double
    var payrollTaxes:Double
    var rent:Double
    var supplies:Double
    var wages:Double
    var repairRevenue:Double
    var interestExpense:Double
    var incomeTaxes:Double
    
    // get base income
    // baseIncomeForBusiness()
    
    func generateNetSales(){
        // net sales = base sales
        
        // compare sales to last
        // price levels
        // advertising
        // management (wages, etc.)
        // random
    }
    
    func generateCostOfSales(){
        
        // base (% of sales)
        // management
    }
    
    func netIncome() -> Double{
        
        print("Net Income \n")
        let grossPofit = revenue - costOfSales
        print("Revenue: \(revenue)")
        print("- cost of sales \(costOfSales)")
        print("= Gross Profit: \(grossPofit)")
        
        
        // Op
        let operations = advertising + insurance + payrollTaxes + rent + supplies + wages
        print("- Operations \(operations)")
        
        let operatingProfit = grossPofit - operations
        
        // income taxes
        let incTax = 0.25 * operatingProfit
        print("- taxes \(incTax)")
        
        let netIncome = Double(Int(operatingProfit - incTax))
        print("= Net income \(netIncome)")
        
        return netIncome
    }
    
}

struct Cashflow:Codable{
    /*
    "cashflow":{
        "period":"W1:2000",
        "netIncome":15283.00,
        "accountsReceivable":-21200.00,
        "inventory":-5625.00,
        "prepaidExpenses":0.00,
        "accountsPayable":8925.00,
        "purchases":-32800.00,
        "mortgage":18000.00,
        "autoLoan":8800.00,
        "ownersInvestment":50000.00,
        "netIncrease":41383.00
    },
     */
    
    var period:String //= "period":"W1:2000",
    var netIncome:Double //"netIncome":15283.00,
    var accountsReceivable:Double // "accountsReceivable":-21200.00,
    var inventory:Double // "inventory":-5625.00,
    var prepaidExpenses:Double // "prepaidExpenses":0.00,
    var accountsPayable:Double // "accountsPayable":8925.00,
    var purchases:Double // "purchases":-32800.00,
    var mortgage:Double // "mortgage":18000.00,
    var autoLoan:Double //  "autoLoan":8800.00,
    var ownerInvestment:Double // "ownersInvestment":50000.00,
    var netIncrease:Double // "netIncrease":41383.00
}

struct BalanceSheet:Codable{
    
    /*
    "balanceSheet":{
        "period":"W1:2000",
        "cash":41383.00,
        "accountsReceivable":21900,
        "allowanceForBadDebts":-700.0,
        "inventory":5625.0,
        "prepaidExpenses":0.0,
        "automobile":12800,
        "land":20000.0,
        "totalAssets":101008.00
        "accountsPayable":8925.0,
        "currentLongTermDebt":900.0,
        "currentNotePayable":400.0,
        "mortgagePayable":18000.0,
        "mortgageShortTerm":-900.0
        "autoPayable":8800.0,
        "autoShort":-400.0,
        "ownersInvestment":50000.00,
        "retainedEarnings":15283.00,
        "totalOwnedEquity":65283.00,
        "totalLiabilities":101008.00
    }
    */
    
    var period:String
    var cash:Double
    var accountsReceivable:Double
    var allowanceForBadDebts:Double
    var inventory:Double
    var prepaidExpenses:Double
    var automobile:Double
    var land:Double
    var totalAssets:Double
    var accountsPayable:Double
    var currentLongTermDebt:Double
    var currentNotePayable:Double
    var mortgagePayable:Double
    var mortgageShortTerm:Double
    var autoPayable:Double
    var autoShort:Double
    var ownersInvestment:Double
    var retainedEarnings:Double
    var totalOwnedEquity:Double
    var totalLiabilities:Double
}

/*
struct AccountingPeriod:Equatable{
    
    var day:Int = 0
    var week:Int = 0
    var year:Int
    
}
 */
