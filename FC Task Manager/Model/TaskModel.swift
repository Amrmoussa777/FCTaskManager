//
//  TaskModel.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 17/02/2023.
//

import Foundation
import UIKit


struct ToDoTask:Codable,Hashable{
    var id:UUID = UUID()
    let name:String
    let desc:String
    let date:Date
    var status:TaskStatus
    let category:TaskCategory
    var createdAt:Date = .now
    
    static let MockToDoTasks:[ToDoTask] = [
        .init(name: "Run daily ", desc: "Run daily by the sea ", date: Calendar.current.date(byAdding: .month, value: -4, to: .now)!, status: .onGoing, category: .WorkTask),
        .init(name: "Run daily 2", desc: "Run daily by the sea ", date:Calendar.current.date(byAdding: .day, value: 9, to: .now)!  ,status: .completed, category: .ShoppingTask),
        .init(name: "Run daily 3", desc: "Run daily by the sea ", date: Calendar.current.date(byAdding: .day, value: 2, to: .now)!,status: .missed, category: .HomeTask),
        .init(name: "Run daily 3 ", desc: "Run daily by the sea ", date:Calendar.current.date(byAdding: .day, value: 3, to: .now)! , status: .completed, category: .ShoppingTask),
        .init(name: "Run daily 5", desc: "Run daily by the sea ", date: Calendar.current.date(byAdding: .day, value: 4, to: .now)!,status: .missed, category: .WorkTask),
        .init(name: "Run daily6 ", desc: "Run daily by the sea ", date: Calendar.current.date(byAdding: .day, value: 5, to: .now)!,status: .onGoing, category: .ShoppingTask),
        .init(name: "Run daily 7", desc: "Run daily by the sea ", date: Calendar.current.date(byAdding: .day, value: 6, to: .now)!,status: .completed, category: .HomeTask),
        .init(name: "Run daily 8", desc: "Run daily by the sea ", date: Calendar.current.date(byAdding: .day, value:7 , to: .now)!,status: .missed, category: .ShoppingTask),
        .init(name: "Run daily 9 ", desc: "Run daily by the sea ", date:Calendar.current.date(byAdding: .day, value: 8, to: .now)!,status: .completed, category: .WorkTask),
    ]
    
    mutating func completeTask(){
        self.status = .completed
    }
}


enum TaskStatus:Int,Codable,Hashable{
    case onGoing = 0
    case completed = 1
    case missed = 2
    
    
    func getColor()->UIColor{
        switch(self){
        case .onGoing:
            return .orange
        case .completed:
            return .primaryGreen
        case .missed:
            return .systemRed
        }
    }
    
    
}

enum TaskCategory:Int,Codable,Hashable,CaseIterable{
    static var allCases: [TaskCategory] = [
        .HomeTask,.ShoppingTask,.WorkTask]
    
    case HomeTask = 0
    case ShoppingTask = 1
    case WorkTask  = 2
    
    
    func getColor()->UIColor{
        switch(self){
        case .HomeTask:
            return .homeTasksColor
        case .ShoppingTask:
            return .shoppingTasksColor
        case .WorkTask:
            return .workTasksColor
        }
    }
    
    func getStringValue()->String{
        switch(self){
        case .HomeTask:
            return "HomeTask"
        case .ShoppingTask:
            return  "ShoppingTask"
        case .WorkTask:
            return "WorkTask"
        }
    }
    
    static func getStrings()->[String]{
        return [
            TaskCategory.WorkTask.getStringValue().localized(),
            TaskCategory.ShoppingTask.getStringValue().localized(),
            TaskCategory.HomeTask.getStringValue().localized()]
    }

}


