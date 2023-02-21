//
//  UIView+EXT.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 17/02/2023.
//

import Foundation
import UIKit
extension UIView{
    static func getSubviewsOfView<T>(v:UIView,typeOF:T.Type) -> [T] {
        var circleArray = [T]()
        
        for subview in v.subviews  {
            circleArray += getSubviewsOfView(v: subview,typeOF: typeOF)
            
            if subview is T {
                circleArray.append(subview as! T)
            }
        }
        return circleArray
    }
    
    func pinToSuperViewEdges(in view:UIView){
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func pinToSuperViewSafeArea(in view:UIView){
        let safeArea = view.safeAreaLayoutGuide
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            topAnchor.constraint(equalTo: safeArea.topAnchor),
            trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
    
    func pinToSuperViewEdgesWithPadding(in view:UIView,padding:CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            topAnchor.constraint(equalTo: view.topAnchor,constant: padding),
            trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -padding)
        ])
    }
    
    
    func roundShape(){
        let radius = frame.size.height / 2
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    
    
     func AddStroke(color:UIColor,strokeWidth:CGFloat = 2){
         layer.borderWidth = strokeWidth
         layer.borderColor = color.cgColor 
     }
    
    
    func addPlaintActivityIndicator(tintColor:UIColor? = nil,style: UIActivityIndicatorView.Style = .large)->UIView{
           let LV = UIActivityIndicatorView(style: style)
           if let tintColor = tintColor {
               LV.color = tintColor
           }
           LV.translatesAutoresizingMaskIntoConstraints = false
           LV.startAnimating()
           addSubview(LV)
           NSLayoutConstraint.activate([
               LV.centerXAnchor.constraint(equalTo: centerXAnchor),
               LV.centerYAnchor.constraint(equalTo: centerYAnchor),
           ])
           return LV
       }
    
    func onTapDismissKeyboard(VC:UIViewController){
          let tap = UITapGestureRecognizer(target: VC, action: #selector(UIInputViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          
          addGestureRecognizer(tap)
      }
}
