//
//  StaffBonusView.swift
//  Business Tycoon
//
//  Created by Farini on 1/2/20.
//  Copyright © 2020 Farini. All rights reserved.
//

import SwiftUI

struct StaffBonusView: View {
    
    var employee:StaffMember
    
    init(employee:StaffMember) {
        self.employee = employee
        self.selected = employee.isChecked
    }
    
    @State private var selected:Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: "person.circle")
                .foregroundColor(.green)
                .font(.body)
            
            Text(employee.name)
            Spacer()
            Button(action: toggle){
                HStack{
                    Image(systemName: selected ? "checkmark.square":"square")
                    Text("Bonus")
                }
            }
        }
    }
    
    func toggle(){selected = !selected}
}


struct StaffBonusView_Previews: PreviewProvider {
    static var previews: some View {
        StaffBonusView(employee: StaffMember(named: "Random dud"))
    }
}
