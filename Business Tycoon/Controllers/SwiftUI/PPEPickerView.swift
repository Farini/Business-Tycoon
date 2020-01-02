//
//  PPEPickerView.swift
//  Business Tycoon
//
//  Created by Farini on 1/2/20.
//  Copyright © 2020 Farini. All rights reserved.
//

import SwiftUI

struct PPEPickerView: View {
    
    let shopArray:[PPEItem] = Bundle.main.decode([PPEItem].self, from: "PPESample.json")
    
    var body: some View {
        List{
            Section(header: Text("PPE Items for sale:")
                .font(.headline)){
                ForEach(shopArray) { ppe in
                    HStack{
                        Text("\(ppe.name)")
                        Spacer()
                        Text("Purch:\(ppe.valueAtPurchase, specifier: "%.2f")")
                        Spacer()
                        Text("Depr:\(ppe.depreciationRate, specifier: "%.2f")")
                    }
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

struct PPEPickerView_Previews: PreviewProvider {
    
    static var previews: some View {
        PPEPickerView()
    }
}
