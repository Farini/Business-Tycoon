//
//  Log.swift
//  Business Tycoon
//
//  Created by Farini on 12/4/19.
//  Copyright © 2019 Farini. All rights reserved.
//

import Foundation

/// The main point for logging all information and messages.
public enum Log {
    
    public static var fileName:String = "Logger"
    
    public static func error(
      _ message: @autoclosure () -> String,
      file: StaticString = #file,
      line: UInt = #line
    ) {
        let header = "ℹ️"
        let fileUrl = URL(fileURLWithPath: "\(file)").lastPathComponent
        
        
    }
    
    /// Logs a non-error message
//    public static func message(
//      _ message: @autoclosure () -> String,
//      file: StaticString = #file,
//      line: UInt = #line
//    ) {
//      let header = "ℹ️"
//      logger.write(
//        composeMessage(
//          header: header,
//          message: message(),
//          filename: "\(file)",
//          line: line
//        )
//      )
//    }
}
