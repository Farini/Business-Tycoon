//
//  IncomeStatementView.swift
//  Business Tycoon
//
//  Created by Farini on 11/6/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit

class IncomeStatementView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    // var bizShop:BizShop?
    
//    func previewWith(bizShop:BizShop){
//        
//        // Cleanup
//        for subV in stackView.arrangedSubviews{
//            subV.removeFromSuperview()
//        }
//        
//        self.bizShop = bizShop
//        
//        // Head
//        let head = makeBoldLabel()
//        head.backgroundColor = UIColor.lightGray
//        head.text = "\(bizShop.name)"
//        stackView.addArrangedSubview(head)
//        
//        // Revenue
//        makeStrongLine(left: "Revenue", right: "$ \(bizShop.income.revenue)")
//        
//        // Cost of sales
//        makeNormalLine(left: "Cost of sales", right: " - $\(bizShop.income.costOfSales)")
//        
//        // Gross Profit
//        let gp = bizShop.income.revenue - bizShop.income.costOfSales
//        makeStrongLine(left: "Gross Profit", right: " $ \(gp)")
//        
//        // Spacer
//        makeSpacer(height: 15.0)
//        
//        // Operations
//        
//        // adv
//        makeNormalLine(left: "Advertising", right: " - \(bizShop.income.advertising)")
//        
//        // bank
//        makeNormalLine(left: "Bank Charge", right: " - \(bizShop.income.bankCharges)")
//        
//        // insurance
//        makeNormalLine(left: "Insurance", right: " - \(bizShop.income.insurance)")
//        
//        // wages
//        makeNormalLine(left: "Wages", right: " - \(bizShop.income.wages)")
//        
//        // payroll
//        makeNormalLine(left: "Payroll tx", right: " - \(bizShop.income.payrollTaxes)")
//        
//        // repair
//        makeNormalLine(left: "Repairs", right: " - \(bizShop.income.repairRevenue)")
//        
//        // Other spacer
//        makeSpacer(height: 15.0)
//        
//        // Operating profit
//        makeStrongLine(left: "Operating Profit", right: "$ \(bizShop.income.netIncome())")
//        
//    }
    
    // Spacer
    func makeSpacer(height:CGFloat){
        
        let width = stackView.frame.width
        
        let spacer = SpacerView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height)))
        spacer.backgroundColor = .clear
        spacer.lineWidth = 2.0
        
        // Constraints
        spacer.translatesAutoresizingMaskIntoConstraints = false
        
        spacer.widthAnchor.constraint(equalToConstant: width).isActive = true
        spacer.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        // Add
        stackView.addArrangedSubview(spacer)
        
    }
    
    // Horizontal Stack
    func makeStrongLine(left:String, right:String){
        
        let hStack = UIStackView()
        
        hStack.axis = .horizontal
        hStack.alignment = .leading
        hStack.distribution = .fill
        
        hStack.spacing = 4
        hStack.backgroundColor = UIColor.yellow
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        let leftLabel = makeBoldLabel()
        // leftLabel.backgroundColor = UIColor.yellow
        leftLabel.text = left
        
        let rightLabel = makeBoldLabel()
        // rightLabel.backgroundColor = UIColor.orange
        rightLabel.text = right
        
        hStack.addArrangedSubview(leftLabel)
        hStack.addArrangedSubview(rightLabel)
        
        stackView.addArrangedSubview(hStack)
        // let wdt = stackView.frame.width
        
        let constraints =
            [hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func makeNormalLine(left:String, right:String){
        
        let hStack = UIStackView()
        
        hStack.axis = .horizontal
        hStack.alignment = .leading
        hStack.distribution = .fill
        hStack.spacing = 4
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        let leftLabel = makeLineLabel()
        // leftLabel.backgroundColor = UIColor.yellow
        leftLabel.text = left
        
        let rightLabel = makeLineLabel()
        // rightLabel.backgroundColor = UIColor.orange
        rightLabel.text = right
        
        hStack.addArrangedSubview(leftLabel)
        hStack.addArrangedSubview(rightLabel)
        
        stackView.addArrangedSubview(hStack)
        // let wdt = stackView.frame.width - 16.0
        
        let constraints =
        [hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    // Labels
    
    func makeBoldLabel() -> UILabel{
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return lbl
    }
    
    func makeLineLabel() -> UILabel{
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lbl
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - Initializers
    
    // for using CustomView in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    // for using CustomView in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
    }
    
    // get xib
    private let nibName:String = "IncomeStatementView"
    private func loadXib(){
        print("Loading Income Statement view")
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        
        // Height adjustment
        // contentView.heightAnchor.constraint(equalToConstant: subcontentView.frame.height).isActive = true
        
        self.addSubview(contentView)
    }
    
}

class SpacerView:UIView{
    
    var lineWidth:CGFloat = 1.0
    var isSolid:Bool = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        // Line
        UIColor.darkGray.set()
        let midlinePattern:[CGFloat] = [3.0, 3.0]
        let midlinePath:UIBezierPath = UIBezierPath()
        
        if !isSolid{
            midlinePath.setLineDash(midlinePattern, count: 2, phase: 0.0)
        }
        
        midlinePath.lineWidth = lineWidth
        
        // Prices separator
        midlinePath.move(to: CGPoint(x: 8.0, y: height / 2))
        midlinePath.addLine(to: CGPoint(x: width - 8.0, y: height / 2))
        midlinePath.stroke()
        
    }
    
    // MARK: - Initializers
    
    // for using CustomView in code
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // for using CustomView in IB
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
