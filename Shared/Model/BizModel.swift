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
        
        print("\n Net Income...")
        let grossPofit = revenue - costOfSales
        print("+ Revenue: \(revenue)")
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
    
    var period:String
    var netIncome:Double
    var accountsReceivable:Double
    var inventory:Double
    var prepaidExpenses:Double
    var accountsPayable:Double
    var purchases:Double
    var mortgage:Double
    var autoLoan:Double
    var ownerInvestment:Double
    var netIncrease:Double
}

struct PPE:Codable{
    var name:String
    var value:Double
    var depreciation:Double
}

struct BalanceSheet:Codable{
    
    // Assets
    
    var period:String
    var cash:Double
    var accountsReceivable:Double
    var allowanceForBadDebts:Double
    var inventory:Double
    var prepaidExpenses:Double
    var automobile:Double
    var land:Double
    var totalAssets:Double
    
    // ====
    // FIXME: - PPE Property, plant and equipment
    // ----
    
    // Liabilities
    
    var accountsPayable:Double
    var currentLongTermDebt:Double
    var currentNotePayable:Double
    
    // Part of debt.....
    // Debt (short term)
    // Debt (long term)
    var mortgagePayable:Double      // deprecate
    var mortgageShortTerm:Double    // deprecate
    var autoPayable:Double          // deprecate
    var autoShort:Double            // deprecate
    
    // Investment
    var ownersInvestment:Double
    var retainedEarnings:Double
    var totalOwnedEquity:Double
    var totalLiabilities:Double
    
    func describe(){
        
        print("\n Balance Sheet...")
        print("Assets")
        print("cash \(cash)")
        print("receivables \(accountsReceivable)")
        print("allow bad debts \(allowanceForBadDebts)")
        print("inventory \(inventory)")
        print("prepaid \(prepaidExpenses)")
        print("--- PPE {")
        print("auto: \(automobile), land:\(land)")
        print("}")
        
        let ttlAssets = cash + accountsReceivable + allowanceForBadDebts + inventory + prepaidExpenses + automobile + land
        
        print("= TOTAL ASSETS: \(ttlAssets)")
        
        print("Liabilities")
        print("payable: \(accountsPayable)")
        print("current lt debt \(currentLongTermDebt)")
        print("current note payable \(currentNotePayable)")
        print("mortgage: \(mortgagePayable)")
        print("short mortgage \(mortgageShortTerm)")
        print("auto payable \(autoPayable)")
        print("auto short \(autoShort)")
        
        print("Owner investment: \(ownersInvestment)")
        print("Retained earnings: \(retainedEarnings)")
        print("total owned equities: \(totalOwnedEquity)")
        
        let ttlLiab = accountsPayable + currentLongTermDebt + currentNotePayable + mortgagePayable + mortgageShortTerm + autoPayable + autoShort
        
        let earn = ownersInvestment + retainedEarnings + totalOwnedEquity
        
        print("Subtotal Liabilities: \(ttlLiab)")
        print("Ownership: \(earn)")
        
        print("= TOTAL LIABILITIES \(ttlLiab + earn)")
        
    }
    
    func basePPECost(){
        
    }
}

struct FinantialDebt{
    
    var principal:Double    // The amount one owes
    var interest:Double     // Interest charged
    var payments:Int        // number of payments (periods)
    
    func begin(){
        
        var accrued:Double = 0.0
        
        for n in 0...payments{
            
            let current = principal - accrued
            let pct = current * (1 + (interest / 100))
            let carrier = current + pct
            
            accrued += current
        }
    }
    
    var cycle:Int // = 0. Current payment
    var paid:Double
    
}

/*
struct AccountingPeriod:Equatable{
    
    var day:Int = 0
    var week:Int = 0
    var year:Int
    
}
 */
