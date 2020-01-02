//  EnvironmentObj.swift
//  Business Tycoon Created by Farini on 1/2/20.
//  Copyright © 2020 Farini. All rights reserved.

import Foundation

class BusinessActions:ObservableObject {
    
    @Published var advertisement:Double
    @Published var staff:[StaffMember]
    
    /// Promotions given to loyal customers (Freebies)
    @Published var loyaltyCare:Double = 0.0
    
    @Published var reStock:Double = 0.0
    @Published var cleanup:Double = 0.0
    
    init(){
        self.advertisement = 50.0
        self.staff = [StaffMember(named: "Mr. Right"), StaffMember(named: "Ms. Right")]
    }
}

class Order:ObservableObject {
    
    @Published var items = [MenuItem]()
    @Published var names = [String]()
    @Published var staff = [StaffMember]()

    init() {
        self.defaultStaff()
    }
    
    var total: Int {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }
    
    /// Sets a default Staff
    func defaultStaff(){
        let s1 = StaffMember(named: "Monkey Donkey")
        let s2 = StaffMember(named: "Monkey doo")
        let s3 = StaffMember(named: "Lobo bobo")
        
        staff = [s1, s2, s3]
    }
    
    func addStaffMember(){
        let member = StaffMember(named: "Otro Loko ?")
        staff.append(member)
    }

    func add(item: MenuItem) {
        items.append(item)
        names.append(item.name)
        staff.append(StaffMember(named: item.name))
    }

    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}

class StaffMember: Codable, Identifiable{

    var id:String
    var name:String
    var isChecked:Bool

    init(named:String) {
        self.name = named
        self.isChecked = false
        self.id = UUID().uuidString
    }
}

struct MenuItem: Codable, Equatable, Identifiable {
    
    var id: UUID
    var name: String
    var photoCredit: String
    var price: Int
    var restrictions: [String]
    var description: String

    var mainImage: String {
        name.replacingOccurrences(of: " ", with: "-").lowercased()
    }

    var thumbnailImage: String {
        "\(mainImage)-thumb"
    }

    #if DEBUG
    static let example = MenuItem(id: UUID(), name: "Maple French Toast", photoCredit: "Joseph Gonzalez", price: 6, restrictions: ["G", "V"], description: "Sweet, fluffy, and served piping hot, our French toast is flown in fresh every day from Maple City, Canada, which is where all maple syrup in the world comes from. And if you believe that, we have some land to sell you…")
    #endif
}
