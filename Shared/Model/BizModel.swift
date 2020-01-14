//  BizModel.swift
//  Business Tycoon: Created by Farini on 11/6/19.
//  Copyright © 2019 Farini. All rights reserved.

import Foundation

// MARK: - Base Structure

class CEO:Codable{
    
    var name:String
    var cash:Double
    var credit:Double
    var tokens:Int
    var influence:Int
    var xp:Int
    
    var businesses:[Business]
    
    init(name:String) {
        
        self.name = name
        self.cash = 5000
        self.credit = 0
        self.tokens = 0
        self.influence = 0
        self.xp = 0
        
        self.businesses = []
    }
    
}

class Business:Codable{
    
    var name:String
    var model:String
    
    var dob:Date // date of birth
    
    var finantials:Finantials
    
    var ppeTree:[PPEItem]
    var ppeAquired:[PPEItem]
    
    enum codingKeys:String, CodingKey {
        case name;
        case model;
        
        case finantials;
        
        case dob;
        case ppeTree;
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        model = try container.decode(String.self, forKey: .model)
        
        finantials = try container.decode(Finantials.self, forKey: .finantials)
        
        // dob (birth)
        if let birth = try? container.decodeIfPresent(Date.self, forKey: .dob){
            dob = birth
        }else{
            dob = Date()
        }
        
        // PPE - Tree
        if let tree = try? container.decodeIfPresent([PPEItem].self, forKey: .ppeTree){
            ppeTree = tree
        }else{
            ppeTree = []
        }
        
        // PPE - Aquired
        if let aquired = try? container.decodeIfPresent([PPEItem].self, forKey: .ppeAquired){
            ppeAquired = aquired
        }else{
            ppeAquired = []
        }
    }
    
    func implement(bizActions:BusinessActions) -> IncomeStatement?{
        
        // The default (use it to generate next)
        let defIncome:IncomeStatement = finantials.incomeStatement
        
        let comps = Calendar(identifier: .gregorian).dateComponents([.year, .quarter, .month, .weekday, .weekOfYear, .day], from: Finantials.dateNow())
        
        let cString = "W \(comps.weekOfYear!) D: \(comps.weekday!)"
        let period:String = cString
        
        // Random
        let random = Double.random(in: -0.2...0.3)
        print("Random: \(random)")
        
        let advertising = bizActions.advertisement
        print("Advertisement: \(advertising)")
        let revenueFromAdvertising = 1.2 * advertising
        
        
        print("Old Revenue: \(defIncome.revenue)")
        let revenue:Double = defIncome.revenue + (defIncome.revenue * random) + revenueFromAdvertising
        print("New Revenue: \(revenue)")
        let costSales = defIncome.costOfSales * random
        
        let badDebtExpense = defIncome.badDebtExpense
        let bankCharges = defIncome.bankCharges
        
        let insurance = defIncome.insurance
        let payrollTX = defIncome.payrollTaxes
        let rent = defIncome.rent
        
        let supplies = defIncome.supplies
        let wages = defIncome.wages
        let repair =  defIncome.repairRevenue
        let interestExpense = defIncome.interestExpense
        let incomeTaxes = defIncome.incomeTaxes
        
        let new = IncomeStatement(period: period, revenue: revenue, costOfSales: costSales, advertising: advertising, badDebtExpense: badDebtExpense, bankCharges: bankCharges, insurance: insurance, payrollTaxes: payrollTX, rent: rent, supplies: supplies, wages: wages, repairRevenue: repair, interestExpense: interestExpense, incomeTaxes: incomeTaxes)
        
        
        return new
    }
    
    
    static var example:Business{
        let bList = Bundle.main.decode([Business].self, from: "ForSale.json")
        return bList.first!
    }
    
    
    // var expansionsOffered:[PPEItem] = []
    // var expansionsUsed:[PPEItem] = []
}

// MARK: - Finantials

class Finantials:Codable{
    
    // Current
    var incomeStatement:IncomeStatement
    var balanceSheet:BalanceSheet
    var cashflow:Cashflow
    
    // History
    var history:[Finantials]
    var date:Date
    
    enum codingKeys:String, CodingKey {
        case incomeStatement;
        case balanceSheet;
        case cashflow;
        
        case history;
        case date;
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        incomeStatement = try container.decode(IncomeStatement.self, forKey: .incomeStatement)
        
        balanceSheet = try container.decode(BalanceSheet.self, forKey: .balanceSheet)
        cashflow = try container.decode(Cashflow.self, forKey: .cashflow)
        
        if let children = try container.decodeIfPresent([Finantials].self, forKey: .history){
            history = children
        }else{
            history = []
        }
        
        if let date = try container.decodeIfPresent(Date.self, forKey: .date){
            self.date = date
        }else{
            self.date = Finantials.dateNow()
        }
    }
    
    
    static func dateNow() -> Date{
       
        var dc = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: Date())
        // dc.timeZone = TimeZone(secondsFromGMT: 0)
        dc.hour = 0
        dc.minute = 0
        dc.second = 0
        dc.nanosecond = 0
        
        let finalDate = dc.date
        return finalDate ?? Date()
            
    }
    
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
    
    // This works
    var grProf:Double {
        return revenue - costOfSales
    }
    
    /// Gets the statement lines
    func lines() -> [FinantialLine]{
        var build:[FinantialLine] = []
    
        // Income
        build.append(FinantialLine(leftHandle: "Revenue", rightHandle: revenue, bold:true))
        build.append(FinantialLine(leftHandle: "COGS", rightHandle: costOfSales))
        let grossProfit = revenue - costOfSales
        build.append(FinantialLine(leftHandle: "GROSS PROFIT", rightHandle: grossProfit, bold:true))
        
        // Separator
        build.append(FinantialLine(leftHandle: "---", rightHandle: nil))
        
        // Operating
        build.append(FinantialLine(leftHandle: "Advertising", rightHandle: advertising))
        build.append(FinantialLine(leftHandle: "Bank charges", rightHandle: bankCharges))
        build.append(FinantialLine(leftHandle: "Insurance", rightHandle: insurance))
        build.append(FinantialLine(leftHandle: "Wages", rightHandle: wages))
        build.append(FinantialLine(leftHandle: "Payroll taxes", rightHandle: payrollTaxes))
        build.append(FinantialLine(leftHandle: "Rent", rightHandle: rent))
        build.append(FinantialLine(leftHandle: "Supplies", rightHandle: supplies))
        build.append(FinantialLine(leftHandle: "Repair revenue", rightHandle: repairRevenue))
        build.append(FinantialLine(leftHandle: "Interest expense", rightHandle: interestExpense))
        let operatingProfit = grossProfit - advertising - bankCharges - insurance - wages - payrollTaxes - rent - supplies - repairRevenue - interestExpense
        build.append(FinantialLine(leftHandle: "OPERATING PROFIT", rightHandle: operatingProfit, bold:true))
        
        // Separator
        build.append(FinantialLine(leftHandle: "---", rightHandle: nil))
        
        // Taxes & Net
        build.append(FinantialLine(leftHandle: "Income Taxes", rightHandle: incomeTaxes))
        let netIncome = operatingProfit - incomeTaxes
        build.append(FinantialLine(leftHandle: "NET INCOME", rightHandle: netIncome, bold:true))
        
        return build
    }
    
    // DEPRECATE THIS
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

struct BalanceSheet:Codable{
    
    var period:String
    
    // Assets
    var cash:Double
    var accountsReceivable:Double
    var inventory:Double
    var prepaidExpenses:Double
    var ppeValue:Double
    var accumulatedDepreciation:Double
    
    // Liabilities
    var accountsPayable:Double
    var shortTermPayables:Double
    var shortTermDebt:Double
    var longTermDebt:Double
    
    // Investment
    var capitalStock:Double
    var shares:Int
    var retainedEarnings:Double
    
    /// Gets the statement lines
    func lines() -> [FinantialLine]{
        var build:[FinantialLine] = []
        
        // Assets
        build.append(FinantialLine(leftHandle: "ASSETS", rightHandle: nil))
        build.append(FinantialLine(leftHandle: "Cash", rightHandle: cash))
        build.append(FinantialLine(leftHandle: "Receivables", rightHandle: accountsReceivable))
        build.append(FinantialLine(leftHandle: "Inventory", rightHandle: inventory))
        build.append(FinantialLine(leftHandle: "Prepaid expenses", rightHandle: prepaidExpenses))
        let currentAssets = cash + accountsReceivable + inventory + prepaidExpenses
        build.append(FinantialLine(leftHandle: "Current Assets", rightHandle: currentAssets))
        
        build.append(FinantialLine(leftHandle: "Property", rightHandle: ppeValue))
        build.append(FinantialLine(leftHandle: "(-) Depreciation", rightHandle: accumulatedDepreciation))
        let totalAssets = currentAssets + ppeValue - accumulatedDepreciation
        build.append(FinantialLine(leftHandle: "TOTAL ASSETS", rightHandle: totalAssets, bold:true))
        
        // Separator
        build.append(FinantialLine(leftHandle: "---", rightHandle: nil))
        
        // Liabilities
        build.append(FinantialLine(leftHandle: "LIABILITIES", rightHandle: nil))
        build.append(FinantialLine(leftHandle: "Payable", rightHandle: accountsPayable))
        build.append(FinantialLine(leftHandle: "Short term payment", rightHandle: shortTermPayables))
        build.append(FinantialLine(leftHandle: "Short term debt", rightHandle: shortTermDebt))
        let currentLiabilities = accountsPayable + shortTermPayables + shortTermDebt
        build.append(FinantialLine(leftHandle: "Current Liabilities", rightHandle: currentLiabilities))
        
        let longTermLiabilities = longTermDebt
        build.append(FinantialLine(leftHandle: "Long term debt", rightHandle: longTermLiabilities))
        let totalLiabilities = currentLiabilities + longTermLiabilities
        build.append(FinantialLine(leftHandle: "LIABILITIES", rightHandle: totalLiabilities))
        
        // Separator
        build.append(FinantialLine(leftHandle: "---", rightHandle: nil))
        
        // Ownership
        build.append(FinantialLine(leftHandle: "OWNERSHIP", rightHandle: nil))
        build.append(FinantialLine(leftHandle: "Capital stock", rightHandle: capitalStock))
        build.append(FinantialLine(leftHandle: "Retained earnings", rightHandle: retainedEarnings, bold:true))
        let shareholdersEquity = capitalStock + retainedEarnings
        build.append(FinantialLine(leftHandle: "Shareholders Equity", rightHandle: shareholdersEquity))
        
        let liabEquity = totalLiabilities + shareholdersEquity
        build.append(FinantialLine(leftHandle: "Liabilities and Equity", rightHandle: liabEquity))
        
        return build
    }
    
    func purchaseValue() -> Double{
        
        print("Calculating purchase value...")
        
        // Assets
        let currentAssets = cash + accountsReceivable + inventory + prepaidExpenses
        // print("CURRENT ASSETS: \(currentAssets)")
        let totalAssets = currentAssets + ppeValue - accumulatedDepreciation
        print("TOTAL ASSETS: \(totalAssets)")
        
        // Liab
        let currentLiabilities = accountsPayable + shortTermPayables + shortTermDebt
        let longTermLiabilities = longTermDebt
        let totalLiabilities = currentLiabilities + longTermLiabilities
        print("TOTAL LIABILITIES: \(totalLiabilities)")
        
        // This brings us to the final eval of how much of the money is actually the owners
        
        // print("Capital stock: \(capitalStock)")
        // print("Retained Earnings: \(retainedEarnings)")
        
        // let oldMoney = capitalStock + retainedEarnings
        // print("SHAREHOLDERS EQUITY (Old): \(oldMoney)")
        
        let newMoney = totalAssets - totalLiabilities
        print("SHAREHOLDERS EQUITY (New): \(newMoney)")
        
        return newMoney
    }
    
                                    
    func describe(){
        
        // Assets
        print("\n ASSETS -")
        print("Cash \(cash)")
        print("Receivables \(accountsReceivable)")
        print("Inventory \(inventory)")
        print("Prepaid expenses \(prepaidExpenses)")
        
        let currentAssets = cash + accountsReceivable + inventory + prepaidExpenses
        print(" = CURRENT ASSETS: \(currentAssets)")
        
        print("PPE \(ppeValue)")
        print("(-) depreciation: \(accumulatedDepreciation)")
        
        let totalAssets = currentAssets + ppeValue - accumulatedDepreciation
        print(" = TOTAL ASSETS: \(totalAssets)")
        
        // Liabilities
        print("\n LIABILITIES -")
        print("payable: \(accountsPayable)")
        print("short term payables \(shortTermPayables)")
        print("short term debt \(shortTermDebt)")
        
        let currentLiabilities = accountsPayable + shortTermPayables + shortTermDebt
        print(" = CURRENT LIABILITIES: \(currentLiabilities)")
        
        print("Long term debt \(longTermDebt)")
        let longTermLiabilities = longTermDebt
        
        let ttlLiabilities = currentLiabilities + longTermLiabilities
        
        // Ownership
        print("\n OWNERSHIP")
        print("Capital stock: \(capitalStock)")
        print("Retained Earnings: \(retainedEarnings)")
        
        let shareholdersEquity = capitalStock + retainedEarnings
        print("TOTAL SHAREHOLDERS EQUITY: \(shareholdersEquity)")
        
        print("\n **")
        let check = totalAssets - ttlLiabilities - shareholdersEquity
        print(" Balance Assets:\(totalAssets)\n Liabilities:\(ttlLiabilities + shareholdersEquity)\n Check \(check)")
        if check == 0.0{
            print("CHECK PASSED !!! 0.00")
        }
        
    }
    
}

/// Finantial line (for Statements)
// FIXME: - Change name to UIFinantialLine
struct FinantialLine{
    var leftHandle:String
    var rightHandle:Double?
    var bold:Bool = false
}

/// Calculates Finantial Debt
class FinantialDebt{
    
    var principal:Double        // The original amount one owes
    var interest:Double         // Interest charged
    var numberOfPayments:Int    // number of payments (periods)
    
    var paidPeriods:Int = 0          // Counter for each payment
    
    /*
     n = 360 (30 years times 12 monthly payments per year)
     i = .005 (6% annually expressed as 0.06, divided by 12 monthly payments per year—learn how to convert percentages to decimal format)
     D = 166.7916 ({[(1+.005)^360] - 1} / [0.005(1+.005)^360])
     P = A / D = 100,000 / 166.7916 = 599.55
     */
    
    // Loan Payment = Amount / Discount Factor or P = A / D
    func loanPayment() -> Double{
        let n = numberOfPayments
        let lft = pow((1 + interest), Double(n)) - 1
        let under = interest * pow(1 + interest, Double(n))
        let discountFactor = lft/under
        
        return principal / discountFactor
    }
    
    /// The number of payments remaining in this debt
    func paymentsRemaining() -> Int{
        return numberOfPayments - paidPeriods
    }
    
    /// The (FV) full amount that will be charged
    func totalAmount() -> Double{
        return loanPayment() * Double(numberOfPayments)
    }
    
    // For Balance Sheet
    
    func shortTermOwed() -> Double{
        let remaining = Double(paymentsRemaining() - numberOfPayments) * loanPayment()
        let twelve = 12.0 * loanPayment()
        return min(remaining, twelve)
    }
    
    func longTermOwed() -> Double{
        if paymentsRemaining() <= 12{
            return 0
        }else{
            return Double(paymentsRemaining() - 12) * loanPayment()
        }
    }
    
    init(amt:Double, n:Int, i:Double) {
        self.principal = amt
        self.numberOfPayments = n
        self.interest = i / 100
    }
}

class PPEItem:Codable, Identifiable{
    
    /* Property, plant and equipment
     --------------------------------
     PPE in Accounting. (pi pi i) or property, plant and equipment. abbreviation. (Accounting: Financial statements)
     PPE is a classification on a balance sheet of a company's fixed assets, such as buildings, computers, furniture, land, and machinery,
     that are expected to be used for more than a year.
    */
    
    var id = UUID()
    
    var name:String
    
    /// The value of object at purchase
    var valueAtPurchase:Double
    
    /// The rate in which the item depreciates
    var depreciationRate:Double
    
    /// The date ppe was purchased
    var purchaseDate:Date
    
    // The effect it has in sales capacity
    var salesCap:Double                 // If it increases the sale capacity of biz
    var salesPitch:Double               // if it increases sales (in general) of biz
    var costReduction:Double            // Reduce cogs ?
    
    // Methods
    
    /// Current age of item
    // var age:Int = 0

    // MARK - Inits
    
    enum codingKeys:String, CodingKey {
        case name;
        case valueAtPurchase;
        case depreciationRate;
        
        case purchaseDate;
        case salesCap;
        case salesPitch;
        case costReduction;
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        valueAtPurchase = try container.decode(Double.self, forKey: .valueAtPurchase)
        depreciationRate = try container.decode(Double.self, forKey: .depreciationRate)
        
        // Sales
        
        if let cap = try? container.decodeIfPresent(Double.self, forKey: .salesCap){
            salesCap = cap
        }else{
            salesCap = 0
        }
        
        if let pitch = try? container.decodeIfPresent(Double.self, forKey: .salesPitch){
            salesPitch = pitch
        }else{
            salesPitch = 0.0
        }
        
        if let reduction = try? container.decodeIfPresent(Double.self, forKey: .costReduction){
            costReduction = reduction
        }else{
            costReduction = 0.0
        }
        
        if let date = try? container.decodeIfPresent(Date.self, forKey: .purchaseDate){
            purchaseDate = date
        }else{
            purchaseDate = Date()
        }
    }
    
    init(example:Bool){
        name = "PPE Item"
        valueAtPurchase = 2.0
        depreciationRate = 0.1
        purchaseDate = Date()
        salesPitch = 0.0
        salesCap = 0.0
        costReduction = 0.0
    }
    
    /// Returns the number of weeks from purchase date
    func currentAgeInWeeks() -> Int{
        return Date().weeksFrom(start: purchaseDate) ?? 0
    }
    
    func accumulatedDepreciation() -> Double{
        let current = Double(currentAgeInWeeks()) * depreciationRate * valueAtPurchase
        return max(0.0, current)
    }
    
    /// period the item will live
    func lifeSpam() -> Int{
        
        var deprecated:Double = 0
        var periods:Int = 0
        
        while deprecated < valueAtPurchase{
            let partialDepreciation = depreciationRate * valueAtPurchase
            deprecated += partialDepreciation
            periods += 1
        }
        
        return periods
    }
    
    /// Life remeining
    func lifeRemaining() -> Int{
        return lifeSpam() - currentAgeInWeeks()
    }
    
    /// The current value (if sold) if the item
    func getCurrentValue() -> Double{
        let cv = valueAtPurchase - accumulatedDepreciation()
        return max(0, cv)
    }
    
    
}




class BizBase:Codable{
    
    var customers:Int = 1
    var walkIns:Int = 1
    
    // PPE
    
    /// PPE's available for purchase
    var availablePPEs:[PPEItem] = []
    
    var includedPPEs:[PPEItem] = []
    
    // Product
    
    var productUnitCost:Double = 1.0
    
    
    init() {
        
    }
}

