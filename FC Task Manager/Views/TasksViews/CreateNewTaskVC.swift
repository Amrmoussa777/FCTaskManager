//
//  CreateNewTaskVC.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 21/02/2023.
//

import UIKit

import UIKit



protocol CreateNewTaskDelegate:AnyObject{
    func updateTasksView(withTask task:Codable)
}

class CreateNewTaskVC: UIViewController {
    
    let viewModel:TasksViewModel
    
    let headerLabel:UILabel = {
        let label  = UILabel()
        label.textAlignment = .natural
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "createTask".localized()
        return label
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
    
    let GoalLabel:UILabel = {
        let label  = UILabel()
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 14)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "yourTaskIS".localized()
        return label
    }()
    
    let goalName:CustomTextView = {
        let label  = CustomTextView(placeholder: "taskExample".localized(), placeHolderColor: .homeTasksColor.withAlphaComponent(0.5), txtColor: .secondaryColor)
        label.font = .systemFont(ofSize: 22)
        label.backgroundColor = .clear
        return label
    }()
    
    let separatorView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
   
    let taskDescLabel:UILabel = {
        let label  = UILabel()
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 14)
        label.text = "desc".localized()
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let taskDescTextView:CustomTextView = {
        let label  = CustomTextView(placeholder: "taskExample".localized(), placeHolderColor: .homeTasksColor.withAlphaComponent(0.5), txtColor: .secondaryColor)
        label.font = .systemFont(ofSize: 22)
        label.backgroundColor = .clear
        return label
    }()
    
    
     let dueDateLabel:UILabel = {
         let label  = UILabel()
         label.textAlignment = .natural
         label.font = .systemFont(ofSize: 14)
         label.text = "dueDate".localized()
         label.textColor = .primaryTextColor
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    
    var  picker:UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.tintColor = .primaryTextColor
        picker.isUserInteractionEnabled = true
        picker.minimumDate = .now
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    
    let  addNewGoal:UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.setTitle("createTask".localized(), for: [])
        button.setTitleColor(.primaryColor, for: .normal)
        button.backgroundColor = .homeTasksColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
 
    
    let selectCategory:UISegmentedControl  = {
        let view  = UISegmentedControl(items: TaskCategory.getStrings())
        view.selectedSegmentIndex = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var delegate:CreateNewTaskDelegate?
    
    
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
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addNewGoal.roundShape()
    }
    
    
    private func configureLayout(){
        view.backgroundColor = .primaryColor
        view.addSubview(headerLabel)
        view.addSubview(taskUserIcon)
        
        view.addSubview(GoalLabel)
        view.addSubview(goalName)
        view.addSubview(separatorView)
        
        view.addSubview(taskDescLabel)
        view.addSubview(taskDescTextView)
        
        view.addSubview(selectCategory)
        
        view.addSubview(dueDateLabel)
        view.addSubview(picker)
        
        view.addSubview(addNewGoal)
        
        let SA = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            taskUserIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            taskUserIcon.topAnchor.constraint(equalTo: SA.topAnchor, constant: 10),
            taskUserIcon.heightAnchor.constraint(equalToConstant: 40),
            taskUserIcon.widthAnchor.constraint(equalToConstant: 40),
            
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerLabel.topAnchor.constraint(equalTo: SA.topAnchor, constant: 10),
            headerLabel.heightAnchor.constraint(equalToConstant: 50),
            headerLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -60),
            
            GoalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            GoalLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            GoalLabel.heightAnchor.constraint(equalToConstant: 20),
            GoalLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -20),
            
            goalName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            goalName.topAnchor.constraint(equalTo: GoalLabel.bottomAnchor, constant: 10),
            goalName.heightAnchor.constraint(equalToConstant: 30),
            goalName.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -10),
            
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            separatorView.topAnchor.constraint(equalTo: goalName.bottomAnchor, constant: 10),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            separatorView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.5),
            
            taskDescLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            taskDescLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 50),
            taskDescLabel.heightAnchor.constraint(equalToConstant: 20),
            taskDescLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.5),
            
            
            taskDescTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            taskDescTextView.topAnchor.constraint(equalTo: taskDescLabel.bottomAnchor, constant: 10),
            taskDescTextView.heightAnchor.constraint(equalToConstant: 70),
            taskDescTextView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.9),
            
            selectCategory.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectCategory.topAnchor.constraint(equalTo: taskDescTextView.bottomAnchor, constant: 50),
            selectCategory.heightAnchor.constraint(equalToConstant: 30),
            selectCategory.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.9),
            
            dueDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dueDateLabel.topAnchor.constraint(equalTo: selectCategory.bottomAnchor, constant: 20),
            dueDateLabel.heightAnchor.constraint(equalToConstant: 20),
            dueDateLabel.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.5),
            
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            picker.topAnchor.constraint(equalTo: dueDateLabel.bottomAnchor, constant: 10),

                    
            addNewGoal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addNewGoal.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 50),
            addNewGoal.heightAnchor.constraint(equalToConstant: 50),
            addNewGoal.widthAnchor.constraint(equalToConstant: 212),
 
        ])
        
        view.onTapDismissKeyboard(VC: self)
        addNewGoal.addTarget(self, action: #selector(createNewGoal), for: .touchUpInside)
    }
    
    
    
    @objc  func createNewGoal(){
        addNewGoal.isUserInteractionEnabled = false
        guard let taskText = goalName.text , taskText != ""  , let descText = taskDescTextView.text , descText != ""  else {
            return
        }
        
        let category  = TaskCategory.allCases.first(where: {
            $0.getStringValue().localized() == TaskCategory.getStrings()[selectCategory.selectedSegmentIndex]
        })
        
        let selectedDate = picker.date
        
        
        let loadingView = addLoadingIndicatior()
        addNewGoal.addSubview(loadingView)
        loadingView.pinToSuperViewEdges(in: addNewGoal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {[weak self] in
            self?.viewModel.addNewTask(name: taskText, desc: descText, date: selectedDate, category: category!)
            self?.dismiss(animated: true)
        })
                
    }
    
    
    
    
    
    
    
    
    @objc func dismissKeyboard(){
        goalName.resignFirstResponder()
        taskDescTextView.resignFirstResponder()
    }
    
    
    func addLoadingIndicatior() -> UIView{
        let view = UIView()
        view.backgroundColor = .secondaryColor
        view.translatesAutoresizingMaskIntoConstraints =  false
        let _ = view.addPlaintActivityIndicator(tintColor: .primaryColor, style: .medium)
        return view
    }
    
    @objc func backTapped(){
        navigationController?.popViewController(animated: true)
    }
    
}




