//  Business Tycoon
//  PlayerDB.swift: Created by Farini on 12/3/19.
//  Copyright © 2019 Farini. All rights reserved.

import Foundation

class PlayerDB:NSObject{
    
    static let filename:String = "PlayerDB.fdb"
    static let shared:PlayerDB = PlayerDB()
    
    /// Initializer
    private override init(){
        print("Database Initialized")
    }
    
    
    func connect(){
        print("Connecting Player DB")
    }
    
    /// Gets the local Database
    func getLocalData() -> Database?{
        
        let filePath:URL = PlayerDB.databaseURL().appendingPathComponent(PlayerDB.filename)
        
        if FileManager.default.fileExists(atPath: filePath.path){
            
            // File exists
            if let fileData:Data = try? Data(contentsOf: filePath){
                
                // Data is here
                if let database:Database = try? JSONDecoder().decode(Database.self, from: fileData){
                    return database
                }
            }
        }
        
        return nil
    }
    
    /** Get the Folder containing Database URL */
    static func databaseURL() -> URL {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
        return documents
    }
}

class Database:Codable{
    
    var ceo:CEO
    
    init(ceo:CEO) {
        self.ceo = ceo
    }
    
}
