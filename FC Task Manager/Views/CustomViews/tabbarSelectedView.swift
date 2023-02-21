//
//  tabbarSelectedView.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import UIKit

class TabSelectedView: UIView {
    let upperView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }
    
    private func configureLayout(){
        upperView.backgroundColor = .secondaryColor
        upperView.translatesAutoresizingMaskIntoConstraints = false
        
       
        addSubview(upperView)
        NSLayoutConstraint.activate([
            upperView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 2),
            upperView.topAnchor.constraint(equalTo: topAnchor,constant: -1),
            upperView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -2),
            upperView.heightAnchor.constraint(equalToConstant: 3),
        ])
    }
}




