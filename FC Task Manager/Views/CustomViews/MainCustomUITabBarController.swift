//
//  MainCustomUITabBarController.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 16/02/2023.
//

import UIKit




/*custom tabBar View on order to add animation.*/
class MainCustomUITabBarController: UITabBarController, UITabBarControllerDelegate {
    
   weak  var coordinator:AppCoordinator?
    
    let tabSelectedView = TabSelectedView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBar.addSubview(tabSelectedView)
        tabBar.standardAppearance.shadowColor = nil
        UITabBar.appearance().barTintColor = UIColor.primaryColor
        
        let rightBarAddButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let rightBarAddButtonImage = UIImage(systemName: "plus")
        rightBarAddButton.setImage(rightBarAddButtonImage, for: .normal)
        rightBarAddButton.layer.cornerRadius = 15
        rightBarAddButton.backgroundColor = UIColor.secondaryColor.withAlphaComponent(0.5)
        rightBarAddButton.imageView?.tintColor = .white
        rightBarAddButton.addTarget(self, action: #selector(addNewTask(sender:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: rightBarAddButton)
        
        let rightBarFilterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let rightBarFilterButtonImage = UIImage.filterImage
        rightBarFilterButton.setImage(rightBarFilterButtonImage, for: .normal)
        rightBarFilterButton.layer.cornerRadius = 15
        rightBarFilterButton.backgroundColor = UIColor.secondaryColor.withAlphaComponent(0.5)
        rightBarFilterButton.imageView?.tintColor = .white
        let rightFilterBarButton = UIBarButtonItem(customView: rightBarFilterButton)
        
        
        let leftImageBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftImageBarButton.layer.cornerRadius = 20
        leftImageBarButton.clipsToBounds = true
        leftImageBarButton.backgroundColor = UIColor.secondaryColor.withAlphaComponent(0.5)
        leftImageBarButton.imageView?.tintColor = .white
        leftImageBarButton.imageView?.contentMode  = .scaleAspectFit
        let leftBarFilterButtonImage = UIImage.profile
        leftImageBarButton.setImage(leftBarFilterButtonImage, for: .normal)
        let leftBarButton = UIBarButtonItem(customView: leftImageBarButton)
        
        
        navigationItem.rightBarButtonItems = [rightBarButton,rightFilterBarButton]
        navigationItem.leftBarButtonItem = leftBarButton
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSelectedView(index: selectedIndex)
    }
    
    
    
    // alternate method if you need the tab bar item
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        updateSelectedView(index: item.tag)
    }
    
    
    private func updateSelectedView(index:Int){
        let arr = tabBar.subviews[2...]
        let barItems = Array(arr)
        let frame = barItems[index].frame
        let center = barItems[index].center
        
        UIView.animate(withDuration: 0.4, delay: 0) {[weak self] in
            self?.tabSelectedView.frame = frame
            self?.tabSelectedView.center = center
        }
    }
    
    
    @objc func addNewTask(sender:UIBarButtonItem){
        coordinator?.openNewTask()
    }
    
    @objc func filterTasks(sender:UIBarButtonItem){
        sender.isSelected.toggle()
        sender.image = sender.isSelected ? .filterImageFill:.filterImage
    }
    
    @objc func searchTasks(sender:UIBarButtonItem){
        
    }
    
    
}





