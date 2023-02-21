//
//  CalendarVC.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//



import UIKit
import Combine

class CalendarVC:UIViewController, UIGestureRecognizerDelegate{
    weak var coordinator:AppCoordinator?
    var viewModel:TasksViewModel
    
    lazy var  picker:UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle  = .inline
        picker.backgroundColor = .primaryColor
        picker.tintColor = .secondaryColor
        picker.isUserInteractionEnabled = true
        picker.translatesAutoresizingMaskIntoConstraints   = false
        return picker
    }()
    
    
    let tasksView:CalendarTasksCollectionView = {
        let view = CalendarTasksCollectionView()
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
        getData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.title = title
        self.markTasks(tasks: viewModel.tasks.value)
    }
    
    
    private func configureLayout(){
        view.backgroundColor = .primaryColor
        
        // calendar view
        view.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picker.heightAnchor.constraint(lessThanOrEqualToConstant: 700)
        ])

        
        picker.addTarget(self, action: #selector(selectDate(sender:)), for: .valueChanged)
       
        let tapGesture  = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipe(sender:)))
        swipeGesture.delegate = self
        swipeGesture.cancelsTouchesInView = false
        
        picker.addGestureRecognizer(tapGesture)
        picker.addGestureRecognizer(swipeGesture)
        
        
         
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(tasksView)
        NSLayoutConstraint.activate([
            tasksView.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor),
            tasksView.topAnchor.constraint(equalTo: picker.bottomAnchor),
            tasksView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tasksView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
//
        tasksView.taskActionDelegate  = coordinator
                
    }
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    func getData(){
        tasksView.updateData(on:viewModel.tasks.value)
    }
    
    
    @objc func selectDate(sender:UIDatePicker){
        let filterTasksPerDay = viewModel.tasks.value.filter({$0.date.isSameDay(with: sender.date)})
        tasksView.updateData(on: filterTasksPerDay)
    }
    
    @objc func tap(sender:UIGestureRecognizer){
        let point = sender.location(in: sender.view)
        if  (point.y < 200){
        for view in  UIView.getSubviewsOfView(v: picker, typeOF: UILabel.self){
            view.superview?.backgroundColor = .clear
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            guard let self = self else {return}
            self.markTasks(tasks: self.viewModel.tasks.value)
        }
       
    }
    
    @objc func swipe(sender:UIGestureRecognizer){
        if sender.state == .ended {
            updateCalendarView()
        }
    }
    
    func updateCalendarView(){
        for view in  UIView.getSubviewsOfView(v: picker, typeOF: UILabel.self){
            view.superview?.backgroundColor = .clear
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            guard let self = self else {return}
            self.markTasks(tasks: self.viewModel.tasks.value)
        }
    }
    
    func markTasks(tasks:[ToDoTask]){
        guard let monthYearLabel = UIView.getSubviewsOfView(v: picker, typeOF: UILabel.self).first , let monthText = monthYearLabel.text?.components(separatedBy: " ").first else {return}
       
        let  tasks = tasks.filter({
            let month  = Calendar(identifier: .iso8601).component(.month, from: $0.date)
            return Date.months[month] == monthText
        })
        
        let  labels = UIView.getSubviewsOfView(v: picker, typeOF: UILabel.self)
        for task in tasks {
            let   day  = Calendar.current.component(.day, from: task.date)
           let ll =  labels.last(where: {
               (Int($0.text ?? "") == day) && !$0.isHidden
            })
            ll?.superview?.backgroundColor = task.status.getColor()
            ll?.superview?.roundShape()
        }
    }
    
    
    // register for any changes in view model
    func registerTaskObserver(){
        viewModel.tasks.sink {[weak self] tasks in
            guard !tasks.isEmpty else{return}
            self?.tasksView.updateData(on: tasks)
            self?.updateCalendarView()
        }.store(in: &cancelable)
    }
}


