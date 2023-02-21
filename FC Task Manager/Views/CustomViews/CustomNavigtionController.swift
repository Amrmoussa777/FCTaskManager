//
//  CustomNavigtionController.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 17/02/2023.
//


import UIKit
class CustomNavigationController:UINavigationController{
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        // Do any additional setup after loading the view.
    }
    
    private func configureLayout(){
        let titleTextAttribute = [NSAttributedString.Key.foregroundColor:UIColor.secondaryColor]
        navigationBar.largeTitleTextAttributes = titleTextAttribute
        navigationBar.titleTextAttributes = titleTextAttribute
        navigationBar.prefersLargeTitles = true
    }
    
    
    func forceRightToLeftView(){
        popToRootViewController(animated: true)
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        
    }
    
    func forceLeftToRightView(){
        popToRootViewController(animated: true)
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        
    }
    
}
