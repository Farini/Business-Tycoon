//
//  Helper.swift
//  A small collection of quick helpers to avoid repeating the same old code.
//
//  Created by Paul Hudson on 23/06/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

extension Bundle {
    
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.dataDecodingStrategy = .deferredToData
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}

extension Date {
    
    func weeksFrom(start:Date) -> Int?{
        
        let calendar = Calendar.current
        let dateComps = calendar.dateComponents([.year, .weekOfYear, .month, .day], from: start, to: Date())
        
        let weeks = dateComps.weekOfYear ?? 0
        if weeks > 0{
            return weeks
        }
        
        return nil
    }
}
