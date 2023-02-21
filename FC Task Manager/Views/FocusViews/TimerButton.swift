//
//  TimerButton.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 20/02/2023.
//

import UIKit


class TimerButton :UIButton{
    var buttonState:TimerButtonStates  = .start{
        didSet{
            updateTitle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        updateTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout(){
        translatesAutoresizingMaskIntoConstraints =  false
        AddStroke(color: .systemOrange)
        setTitleColor(.systemOrange, for: [])
        titleLabel?.font = .boldSystemFont(ofSize: 17)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundShape()
    }
    
    private func updateTitle(){
        setTitle(buttonState.rawValue.localized(), for: [])
    }
    
     func toggleSelection(){
        buttonState.toggle()
    }
    
}


enum TimerButtonStates:String{
    case start = "startTimer"
    case pause = "stopTimer"
    
    
    mutating func toggle(){
        self =  self == .start ? .pause:.start
    }
}
