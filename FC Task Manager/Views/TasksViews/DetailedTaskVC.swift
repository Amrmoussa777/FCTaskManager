//
//  DetailedTaskVC.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 20/02/2023.
//

import UIKit
class DetailedTaskVC:UIViewController{
    
    let viewModel:TasksViewModel
    var task:ToDoTask?
    
    let statusIndicator:UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7.5
        view.clipsToBounds = true
        return view
    }()
    
    
    let taskUserIcon:UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.tintColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints =  false
        view.image = .profile
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let taskCategory:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .primaryColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .monospacedSystemFont(ofSize: 17, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.AddStroke(color: .primaryColor)
        return label
    }()
    
    let taskName:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .primaryColor
        label.font = .boldSystemFont(ofSize: 50)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLeftLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .secondaryColor
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "timeLeft".localized()
        return label
    }()
    
    
    let assigneeLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .secondaryColor
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "assignee".localized()
        return label
    }()
    
   
    
    let taskTime:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .primaryColor
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let DescLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .secondaryColor
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "desc".localized()
        return label
    }()
    
    let taskDesc:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .primaryColor
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deleteButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.setTitleColor(.red, for: [])
        button.setTitle("deleteTask".localized(), for: [])
        button.AddStroke(color: .red)
        return button
    }()
    
    let taskCompleteView:SlideToComplete = {
        let view = SlideToComplete()
        return view
    }()
        
    
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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        taskCategory.roundShape()
        deleteButton.roundShape()
    }
    
    private func configureLayout(){
        if let sheetController = self.presentationController as? UISheetPresentationController {
            sheetController.detents = [.medium(), .large()]
        }
        
        view.backgroundColor = .systemBackground
        
        
        view.addSubview(statusIndicator)
        view.addSubview(taskUserIcon)
        view.addSubview(taskCategory)
        view.addSubview(taskName)
        view.addSubview(taskDesc)
        view.addSubview(taskTime)
        view.addSubview(DescLabel)
        view.addSubview(timeLeftLabel)
        view.addSubview(assigneeLabel)
        
        view.addSubview(deleteButton)
        view.addSubview(taskCompleteView)
        
        
        NSLayoutConstraint.activate([
            taskCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            taskCategory.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            taskCategory.heightAnchor.constraint(equalToConstant: 40),
            taskCategory.widthAnchor.constraint(equalToConstant: 120),
            

            taskCompleteView.leadingAnchor.constraint(equalTo:  view.leadingAnchor,constant: 20),
            taskCompleteView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            taskCompleteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            taskCompleteView.heightAnchor.constraint(equalToConstant: 65),
            
            deleteButton.leadingAnchor.constraint(equalTo:  view.leadingAnchor,constant: 20),
            deleteButton.bottomAnchor.constraint(equalTo:taskCompleteView.topAnchor,constant: -10),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 65),
            
            taskName.leadingAnchor.constraint(equalTo:  view.leadingAnchor,constant: 20),
            taskName.topAnchor.constraint(equalTo: taskCategory.bottomAnchor,constant: 5),
            taskName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            taskName.heightAnchor.constraint(lessThanOrEqualToConstant: 120),
            
            
            timeLeftLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            timeLeftLabel.topAnchor.constraint(equalTo: taskName.bottomAnchor,constant: 10),
            timeLeftLabel.heightAnchor.constraint(equalToConstant: 20),
            
            taskTime.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            taskTime.topAnchor.constraint(equalTo: timeLeftLabel.bottomAnchor, constant: 5),
            taskTime.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
            
            assigneeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            assigneeLabel.topAnchor.constraint(equalTo: taskName.bottomAnchor,constant: 10),
            assigneeLabel.heightAnchor.constraint(equalToConstant: 20),
           
            taskUserIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            taskUserIcon.topAnchor.constraint(equalTo: assigneeLabel.bottomAnchor,constant: 10),
            taskUserIcon.widthAnchor.constraint(equalToConstant: 40),
            taskUserIcon.heightAnchor.constraint(equalToConstant: 40),

            statusIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            statusIndicator.centerYAnchor.constraint(equalTo:  taskCategory.centerYAnchor),
            statusIndicator.heightAnchor.constraint(equalToConstant: 15),
            statusIndicator.widthAnchor.constraint(equalToConstant: 15),

            DescLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            DescLabel.topAnchor.constraint(equalTo: taskTime.bottomAnchor,constant: 20),
            DescLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
            DescLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 30),
            
            taskDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            taskDesc.topAnchor.constraint(equalTo: DescLabel.bottomAnchor,constant: 5),
            taskDesc.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            taskDesc.bottomAnchor.constraint(lessThanOrEqualTo:taskCompleteView.topAnchor,constant: -10),
        ])
        
        taskCompleteView.completionDelegate = self
        deleteButton.addTarget(self, action: #selector(deleteTask), for: .touchUpInside)
    }
    
    func setTask(with task:ToDoTask){
        self.task = task
        view.backgroundColor = task.category.getColor()
        statusIndicator.backgroundColor = task.status.getColor()
        deleteButton.backgroundColor = task.category.getColor()
        taskName.text = task.name
        taskDesc.text = task.desc
        taskTime.text  = task.date.timeAgoDisplay(locale: String.language.rawValue)
        taskCategory.text = task.category.getStringValue().localized()
    }
    
    @objc func deleteTask(){
        guard let task = task else{return}
        viewModel.deleteTask(task: task)
        dismiss(animated: true)
    }
}


extension DetailedTaskVC:SliderCompletionDelegate{
    func sliderCompleted() {
        guard let task = task else{return}
        viewModel.setCompleted(for: task)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {[weak self] in
            self?.taskCompleteView.completeLoading()
        })
    }
    
    func confirmationCompleted() {
        dismiss(animated: true)
    }
}
