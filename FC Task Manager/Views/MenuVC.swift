//
//  MenuVC.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import Foundation


import UIKit


class MenuVC:UIViewController{
    weak var coordinator:AppCoordinator?
    var viewModel:TasksViewModel
    
    let changeLanguageButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.setTitleColor(.homeTasksColor, for: [])
        button.setTitle("changeLanguage".localized(), for: [])
        button.AddStroke(color: .homeTasksColor)
        return button
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.title = title
    }
    
    
    private func configureLayout(){
        view.backgroundColor = .primaryColor
        view.addSubview(changeLanguageButton)
        NSLayoutConstraint.activate([
            changeLanguageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            changeLanguageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            changeLanguageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            changeLanguageButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        changeLanguageButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
    }
    
    @objc func changeLanguage(){
        coordinator?.changeLanguage()
    }
    
}
