//
//  FocusVC.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import Foundation
import UIKit


class FocusVC:UIViewController{
    weak var coordinator:AppCoordinator?
    var viewModel:TasksViewModel
    
    
    var timerView:TimerView?
    
    let headLine:UILabel = {
        let label  =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.font = .monospacedSystemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryColor
        label.textAlignment = .center
        label.numberOfLines  = 0
        label.text = "focusHeader".localized()
        return label
    }()
    
    let timerButton:TimerButton = {
        let timerButton = TimerButton()
        return timerButton
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
        addTimerView(withSeconds:20*60)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.title = title
    }
    
    
    private func configureLayout(){
        view.backgroundColor = .primaryColor
        view.addSubview(headLine)
        view.addSubview(timerButton)
        
        NSLayoutConstraint.activate([
            timerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            timerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            timerButton.heightAnchor.constraint(equalToConstant: 70),
            
            headLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20 ),
            headLine.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            headLine.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
        ])
        timerButton.addTarget(self, action: #selector(toggleTimeState(sender:)), for: .touchUpInside)
    }
    
    private func addTimerView(withSeconds time:Int){
        timerView = TimerView(duration: time)
        guard let timerView = timerView else {return }
        view.addSubview(timerView)
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            timerView.heightAnchor.constraint(equalTo: timerView.widthAnchor),
        ])
        
        timerView.timerDelegate = self
    }
    
    @objc private  func toggleTimeState(sender:TimerButton){
        sender.buttonState == .start ?  StartTimer():StopTimer()
        sender.toggleSelection()
    }
    
    private func StartTimer(){
        timerView?.resumeTimer()
    }
    
    private func StopTimer(){
        timerView?.pauseTimer()
    }
}


extension FocusVC:TimerStatus{
    func timerFinished() {
        
    }
    
    
}
