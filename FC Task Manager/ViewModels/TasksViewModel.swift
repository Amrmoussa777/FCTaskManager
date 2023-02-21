//
//  TasksViewModel.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import Foundation
import Combine


class TasksViewModel{

    let persistence = TasksLocalPersistence(modelName: "TasksDataModel")
    
    var tasks = CurrentValueSubject<[ToDoTask],Never>([])
    
    init(){
        fetchTasks()
    }
    
    
    func addNewTask(name:String,desc:String,date:Date,category:TaskCategory){
        let newTask = ToDoTask(id: .init(), name: name, desc: desc, date: date, status: .onGoing, category: category)
        persistence.saveTask(forTask: newTask)
        fetchTasks()
    }
    
    func deleteTask(task:ToDoTask){
        persistence.deleteTask(task: task) ? fetchTasks():()
    }
    
    func setCompleted(for task:ToDoTask){
        if let index  =   tasks.value.firstIndex(where:{$0.id == task.id}){
            var newTask =  tasks.value[index]
            newTask.completeTask()
            tasks.value[index] = newTask
            persistence.saveTask(forTask: newTask)
            fetchTasks()
        }
    }
    
    func fetchTasks(){
        tasks.value = persistence.fetchTasks().sorted(by: {$0.date < $1.date})
    }
}


