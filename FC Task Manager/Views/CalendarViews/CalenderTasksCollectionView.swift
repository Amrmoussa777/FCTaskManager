//
//  CalenderTasksCollectionView.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 17/02/2023.
//



import UIKit

class CalendarTasksCollectionView:UIView {
    
    
    enum Section { case main }
    
    var tasks: [ToDoTask]     = []
              
    
    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var dataSource: UICollectionViewDiffableDataSource<Section, ToDoTask>!
    
    var page:Int = 1
    
    var isSearching =  false
    var taskActionDelegate:TaskActionProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureCollectionView()
        configureDataSource()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    func configureView() {
        translatesAutoresizingMaskIntoConstraints =  false
        backgroundColor = .clear
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant:0),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])

        
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.alwaysBounceVertical = true
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.reuseIdentifier)
        
        
    }
    
    
    
    func configureDataSource() {
        
        // cell items
        dataSource = UICollectionViewDiffableDataSource<Section, ToDoTask>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, task) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
            cell.setTask(with: task)
            return cell
        })
        
        
        
        
    }
    
    
    func updateData(on items: [ToDoTask]) {
       applyCurrentSnapSHot(on: items)
    }
   
    
    func applyCurrentSnapSHot(on items: [ToDoTask]){
        self.tasks  = items
        var snapshot = NSDiffableDataSourceSnapshot<Section, ToDoTask>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    

 
    
    
    
    
}


extension CalendarTasksCollectionView: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height && !isSearching{
//            getMoreItems()
        }


        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        taskActionDelegate?.selectTask(task: tasks[indexPath.row])
    }
    

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 0, bottom: 10, right: 0)
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size =  collectionView.frame.size
         return .init(width: (size.width-20), height: 150)
    }
    
    
    
    
}



