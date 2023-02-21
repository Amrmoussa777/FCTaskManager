//
//  TimeInterval+EXT.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 20/02/2023.
//

import Foundation

extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}
