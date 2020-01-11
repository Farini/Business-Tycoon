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
                    PPEItemRow(item: ppe)
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

struct PPEItemRow: View {
    
    var item:PPEItem
    
    var body: some View {
        VStack{
            HStack{
                Text("\(item.name)")
                    .font(.headline)
                    .padding(.all, 3)
                
                Spacer()
                
            }
            HStack{
                Text("Purch:\(item.valueAtPurchase, specifier: "%.2f")")
                Spacer()
                Text("Depr:\(item.depreciationRate, specifier: "%.2f")")
            }
            HStack{
                Text("Life: \(item.lifeSpam()) weeks")
                    .font(.callout)
                Spacer()
            }
            HStack{
                Text(" + sales ")
                    .background(Color.green)
                    .cornerRadius(8)
                    .foregroundColor(Color.white)
                    .padding(.all, 3)
                Text("$\(item.salesCap, specifier: "%.2f")")
                Spacer()
                Text(" + pitch ")
                .background(Color.orange)
                .cornerRadius(8)
                .foregroundColor(Color.white)
                .padding(.all, 3)
                Text("Cap:\(item.salesPitch, specifier: "%.2f")")
            }
            HStack{
                Text(" - costs ")
                .background(Color.red)
                .cornerRadius(8)
                .foregroundColor(Color.white)
                .padding(.all, 3)
                Text("\(item.costReduction, specifier: "%.2f")")
                Spacer()
            }
            HStack{
                Spacer()
                Image(systemName: "cart.fill")
                Image(systemName: "cart")
                Text("Purchase")
                    .font(.callout)
                
            }
        }
    }
}

struct PPEItemRow_Previews: PreviewProvider {
    
    static var previews: some View {
        PPEItemRow(item: PPEItem(example: true))
    }
}
