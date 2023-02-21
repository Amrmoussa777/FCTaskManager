//
//  TaskCollectionViewCell.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 17/02/2023.
//

import Foundation
import UIKit
class TaskCell:UICollectionViewListCell{
    static let reuseIdentifier = "TaskCell"
    
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
        label.font = .monospacedSystemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskName:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .primaryColor
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    let taskTime:UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = .primaryColor
        label.font = .italicSystemFont(ofSize: 13)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureLayout(){
        layer.cornerRadius = 30
        clipsToBounds = true
        layer.masksToBounds = true
        
        contentView.addSubview(statusIndicator)
        contentView.addSubview(taskUserIcon)
        contentView.addSubview(taskCategory)
        contentView.addSubview(taskName)
        contentView.addSubview(taskDesc)
        contentView.addSubview(taskTime)
        
        NSLayoutConstraint.activate([
            taskUserIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            taskUserIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            taskUserIcon.widthAnchor.constraint(equalToConstant: 40),
            taskUserIcon.heightAnchor.constraint(equalToConstant: 40),
            
            statusIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            statusIndicator.centerYAnchor.constraint(equalTo:  taskUserIcon.centerYAnchor),
            statusIndicator.heightAnchor.constraint(equalToConstant: 15),
            statusIndicator.widthAnchor.constraint(equalToConstant: 15),
            
    
            taskTime.centerYAnchor.constraint(equalTo: taskUserIcon.centerYAnchor),
            taskTime.trailingAnchor.constraint(equalTo: statusIndicator.leadingAnchor, constant: -10),
            taskTime.heightAnchor.constraint(equalToConstant: 40),
            taskTime.widthAnchor.constraint(lessThanOrEqualToConstant: 70),
            
            taskCategory.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            taskCategory.topAnchor.constraint(equalTo: taskUserIcon.bottomAnchor,constant: 5),
            taskCategory.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
            
            taskName.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor,constant: 20),
            taskName.topAnchor.constraint(equalTo: taskCategory.bottomAnchor,constant: 5),
            taskName.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
            taskName.heightAnchor.constraint(lessThanOrEqualToConstant: 30),
            
            taskDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            taskDesc.topAnchor.constraint(equalTo: taskName.bottomAnchor,constant: 5),
            taskDesc.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
            taskDesc.bottomAnchor.constraint(lessThanOrEqualTo:contentView.bottomAnchor,constant: -10),
        ])

    }
    
    
    func setTask(with task:ToDoTask){
        contentView.backgroundColor = task.category.getColor()
        statusIndicator.backgroundColor = task.status.getColor()
        taskName.text = task.name
        taskDesc.text = task.desc
        taskTime.text  = task.date.timeAgoDisplay(locale: String.language.rawValue)
        taskCategory.text = task.category.getStringValue().localized()
    }
    
}
