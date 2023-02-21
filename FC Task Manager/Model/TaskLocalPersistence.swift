//
//  TaskLocalPersistence.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 21/02/2023.
//


import CoreData

class TasksLocalPersistence {
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    
    func saveTask(forTask task:ToDoTask){
        
         do {
             let dataTask = try find(id: task.id, in: managedContext)
             dataTask.setValuesForKeys([
                     "id":task.id  ,
                     "name":task.name,
                     "desc":task.desc,
                     "date":task.date,
                     "category":task.category.rawValue,
                     "status":task.status.rawValue,
                     "createdAt":task.createdAt
             ])
           try managedContext.save()
           
         } catch let error as NSError {
           print("Could not save. \(error), \(error.userInfo)")
         }
    }
    
    
    func fetchTasks()->[ToDoTask]{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            request.returnsObjectsAsFaults = false
        var tasks:[ToDoTask] = []
            do {
                let result = try managedContext.fetch(request)
                for data in result as! [NSManagedObject] {
                  let id =  data.value(forKey: "id") as! UUID
                  let name = data.value(forKey: "name") as! String
                  let desc = data.value(forKey: "desc") as! String
                  let date = data.value(forKey: "date") as! Date
                  let createdAt = data.value(forKey: "createdAt") as! Date
                  let category = data.value(forKey: "category") as! Int
                  let status = data.value(forKey: "status") as! Int
                    
                    let task = ToDoTask(id: id, name: name, desc: desc, date: date, status: TaskStatus(rawValue: status)!, category: TaskCategory(rawValue: category)!, createdAt: createdAt)
                    tasks.append(task)
                }
            } catch {
                print("Fetching data Failed")
            }
        
        return tasks
    }
    
    
    
    
    func find(id :UUID, in context: NSManagedObjectContext) throws -> NSManagedObject {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        let result = try context.fetch(request)
        if let task = result.first {
            return task as! NSManagedObject
        } else {
            let newTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context)
            return newTask
        }
    }
    
    
    func deleteTask(task:ToDoTask)->Bool{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        do{
            guard let task = try managedContext.fetch(request).first as? NSManagedObject else{return false}
            managedContext.delete(task)
            try managedContext.save()
            return true
        }catch{
            return false
        }
    }
    
}
