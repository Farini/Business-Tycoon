//
//  BizStatementCell.swift
//  Business Tycoon
//
//  Created by Farini on 11/12/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import UIKit

class BizStatementCell: UITableViewCell {
    
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    let normalSize:CGFloat = 17.0
    let boldSize:CGFloat = 18.0

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add labels
        
        // Left
        addSubview(leftLabel)
        leftLabel.backgroundColor = UIColor.yellow
        leftLabel.text = "Left label"
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leftConstraints = [leftLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
        leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
        leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
        leftLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)]
        NSLayoutConstraint.activate(leftConstraints)
        
        // Right
        addSubview(rightLabel)
        rightLabel.textAlignment = .right
        rightLabel.backgroundColor = UIColor.green
        rightLabel.text = "Right label"
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let rightConstrraints = [rightLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
        rightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200),
        rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2),
        rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)]
        NSLayoutConstraint.activate(rightConstrraints)
        
    }
    
    func prepareLine(line:FinantialLine){
        
        // Left Label
        leftLabel.text = line.leftHandle
        
        // Right Label
        if let value = line.rightHandle{
            rightLabel.text = "\(value)"
        }else{
            rightLabel.text = ""
        }
        
        // Bold
        if line.bold == true{
            leftLabel.font = UIFont.boldSystemFont(ofSize: boldSize)
            rightLabel.font = UIFont.boldSystemFont(ofSize: boldSize)
        }else{
            leftLabel.font = UIFont.systemFont(ofSize: normalSize)
            rightLabel.font = UIFont.systemFont(ofSize: normalSize)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
