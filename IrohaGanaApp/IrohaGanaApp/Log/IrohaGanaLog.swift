//
//  IrohaGanaLog.swift
//  IrohaGanaApp
//
//  Created by aokita on 2020/02/08.
//  Copyright © 2020 irodori. All rights reserved.
//

import Foundation

struct IrohaGanaLog {

    static func Error(_ log: Any = "", function: String = #function, file: String = #file, line: Int = #line) {
        let filename: String = file.components(separatedBy: "/").last ?? ""
        IrohaGanaLog._print("🚨 \(String(describing: filename))(\(line)) \(function) \(log)")
    }

    static func Debug(_ log: Any = "", function: String = #function, file: String = #file, line: Int = #line) {
        let filename: String = file.components(separatedBy: "/").last ?? ""
        IrohaGanaLog._print("🚛 \(String(describing: filename))(\(line)) \(function) \(log)")
    }

    private static func _print(_ log: String) {
        print(log)
    }
}
