//
//  HomeVC.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import Foundation
import UIKit
import Combine

class TasksVC:UIViewController{
    weak var coordinator:AppCoordinator?
    var viewModel:TasksViewModel
    
    let tasksView:TasksCollectionView = {
        let view =  TasksCollectionView()
        return view 
    }()
    
    var cancelable = Set<AnyCancellable>()
    init(viewModel:TasksViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        registerTaskObserver()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.title = title
    }
    
    private func configureLayout(){
        view.backgroundColor = .primaryColor
        view.addSubview(tasksView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tasksView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            tasksView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            tasksView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant:0),
            tasksView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        
        tasksView.taskActionDelegate = coordinator
    }
    
    
   
    func registerTaskObserver(){
        viewModel.tasks.sink {[weak self] tasks in
            guard !tasks.isEmpty else{return}
            self?.tasksView.updateData(on: tasks)
        }.store(in: &cancelable)
    }
}


