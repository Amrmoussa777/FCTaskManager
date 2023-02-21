//
//  UIDate+EXT.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 17/02/2023.
//

import Foundation



extension Date{
    static let  months:[Int:String] = [
        1 :"January",
        2 :"February",
        3:"March",
        4 :"April",
        5:"May",
        6 :"June",
        7 :"July",
        8:"August",
        9 :"September",
        10 :"October",
        11:"November",
        12 :"December",
    ]
    
    
    func isSameDay(with date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: self, to: date2)
        let date1Day = Calendar.current.component(.day, from: self)
        let date2Day = Calendar.current.component(.day, from: date2)
        
        if diff.day == 0 && (date1Day == date2Day) {
            return true
        } else {
            return false
        }
    }
    
    func getDateAndTime(withFormat format:String,withLocal local :String? = nil) ->String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let local = local {
            formatter.locale = Locale(identifier: local)
        }
        let res = formatter.string(from: self)
        return res
    }
    
    func timeAgoDisplay(locale:String) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale =  Locale(identifier: locale)
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func getDateAndTime() ->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        let res = formatter.string(from: self)
        return res
    }
    
}
