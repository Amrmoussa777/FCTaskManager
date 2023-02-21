//
//  App Coordinator.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import Foundation
import UIKit


/* the root coordinator
to launch the tabBar */
class AppCoordinator:Coordinator{
    
    var childCoordinators: [Coordinator] = []
    var window:UIWindow
    
    var navigationController: CustomNavigationController?
    var tasksViewModel = TasksViewModel()
    
    var tabBar:MainCustomUITabBarController?
    
    func initialize() {
        createTabBar()
        goToMainVC()
    }
    
    init(window:UIWindow){
        self.window = window
    }
    


    private func createTabBar(){
        let tabBar = MainCustomUITabBarController()
        tabBar.tabBar.backgroundColor = .primaryColor
        tabBar.tabBar.tintColor = .secondaryColor
        tabBar.tabBar.isTranslucent = false
        tabBar.coordinator = self
        tabBar.viewControllers = [createHome(),createCalendarVC(),createFocusVC(),createMenuVC()]
        self.tabBar = tabBar
        self.tabBar?.title = "tasks".localized()
    }
    
    
    private  func createHome() -> UIViewController {
        let homeVC = TasksVC(viewModel: tasksViewModel)
        homeVC.tabBarItem = UITabBarItem(title: "tasks".localized(), image: .homeIcon, tag: 0)
        homeVC.coordinator = self
        homeVC.title  = "tasks".localized()
        return homeVC
    }
    
   
    
    private  func createCalendarVC() -> UIViewController {
        let calendarVC = CalendarVC(viewModel: tasksViewModel)
        calendarVC.tabBarItem = UITabBarItem(title: "calendar".localized(), image: .calendarIcon, tag: 1)
        calendarVC.coordinator = self
        calendarVC.title  = "calendar".localized()
        return calendarVC
    }
    
    
    private  func createFocusVC() -> UIViewController {
        let focusVC = FocusVC(viewModel: tasksViewModel)
        focusVC.tabBarItem = UITabBarItem(title: "focus".localized(), image: .focusIcon, tag: 2)
        focusVC.coordinator = self
        focusVC.title  = "focus".localized()
        return focusVC
    }
    
    private func createMenuVC() -> UIViewController {
        let profileVC = MenuVC(viewModel: tasksViewModel)
        profileVC.tabBarItem = UITabBarItem(title: "menu".localized(), image: .menuIcon, tag: 3)
        profileVC.coordinator = self
        profileVC.title  = "menu".localized()
        return profileVC
    }
    

    private func goToMainVC(){
        guard let tabBar = tabBar else {
            return
        }
        
        navigationController = CustomNavigationController(rootViewController: tabBar)
        window.rootViewController = navigationController
        navigationController?.setViewControllers([tabBar], animated: true)
    }
    
    
    func openNewTask(){
        let newTask = CreateNewTaskVC(viewModel: tasksViewModel)
        navigationController?.present(newTask, animated: true)
    }
   
    
     func popMe(VC:UIViewController){
        VC.navigationController?.popViewController(animated: true)
    }
    
    
    func changeLanguage(){
        String.language == .en ? setArabicLanguage():setEnglishLanguage()
    }
    
    func setArabicLanguage(){
        String.language = .ar
        navigationController?.forceRightToLeftView()
        restartAPP()
    }
    
    func setEnglishLanguage(){
        String.language = .en
        navigationController?.forceLeftToRightView()
        restartAPP()
    }
  
    
    func restartAPP(){
        window.rootViewController?.dismiss(animated: true)
        initialize()
    }
    
    
    
    
    
    
}


extension AppCoordinator:TaskActionProtocol{
    func selectTask(task: ToDoTask) {
        let detailedTask = DetailedTaskVC(viewModel: tasksViewModel)
        detailedTask.setTask(with: task)
        navigationController?.present(detailedTask, animated: true)
    }
}
