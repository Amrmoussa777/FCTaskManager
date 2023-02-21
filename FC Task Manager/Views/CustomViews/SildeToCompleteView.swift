//
//  SilderView.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 20/02/2023.
//


import UIKit
import AVFoundation

protocol SliderCompletionDelegate:AnyObject{
    func sliderCompleted()
    func confirmationCompleted()
}

class SlideToComplete:UIView{
    let label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .monospacedSystemFont(ofSize: 15, weight: .regular)
        label.textColor = .label.withAlphaComponent(0.5)
        label.text = "markAsCompleted".localized()
        label.backgroundColor = .clear
        return label
    }()
    
    
    let slider:UIImageView = {
        let slider = UIImageView()
        slider.backgroundColor = .systemGreen
        slider.translatesAutoresizingMaskIntoConstraints =  false
        slider.image = .rightSlide
        slider.contentMode = .center
        slider.tintColor = .white
        return slider
    }()
    
    var loadingView:UIView?
    var originalHorizontalPositionOfCancel:CGFloat = 10
    
    var completionDelegate:SliderCompletionDelegate?
    
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
        roundShape()
        slider.roundShape()
    }
    
    
    private func configureLayout(){
        backgroundColor = .systemGray5
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.pinToSuperViewEdges(in: self)
        sendSubviewToBack(label)
        
        addSubview(slider)
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            slider.centerYAnchor.constraint(equalTo: centerYAnchor),
            slider.heightAnchor.constraint(equalToConstant: 50),
            slider.widthAnchor.constraint(equalTo: slider.heightAnchor),
        ])
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(touched(_:)))
        slider.addGestureRecognizer(gestureRecognizer)
        slider.isUserInteractionEnabled = true
    }
    
    @objc private func touched(_ gestureRecognizer: UIGestureRecognizer) {
          if let touchedView = gestureRecognizer.view {
              if gestureRecognizer.state == .changed {
                  let locationInView = gestureRecognizer.location(in: touchedView)

                  var newPos = touchedView.frame.origin.x + locationInView.x
                  
                  // limit the scrolls to the edges of the parent view
                  if newPos < 10 {
                      newPos = 10
                  } else if newPos > 250 {
                      newPos = 250
                  }
                  
                  touchedView.frame.origin.x = newPos
              } else if gestureRecognizer.state == .ended {
                  if touchedView.frame.origin.x == 250 {
                      setLoading()
                  } else {
                      touchedView.frame.origin.x = originalHorizontalPositionOfCancel
                  }
              }

              UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
                  self.layoutIfNeeded()
              }, completion: nil)
          }
      }
    
    
    func setLoading(){
        slider.image = nil
        UIView.animate(withDuration: 0.5, delay: 0) {[weak self] in
            AudioServicesPlayAlertSound(1312)
            self?.backgroundColor = .clear
            self?.label.alpha = 0
            self?.slider.frame.origin.x = (self?.bounds.width ?? CGFloat(0))/CGFloat(2) - 25
            self?.slider.isUserInteractionEnabled = false
        } completion: {[weak self] _ in
            self?.loadingView =  self?.slider.addPlaintActivityIndicator(tintColor: .label.withAlphaComponent(0.6), style: .medium)
            self?.completionDelegate?.sliderCompleted()
        }
    }
    
    func restoreState(){
        UIView.animate(withDuration: 0.5, delay: 0) {[weak self] in
            self?.loadingView?.removeFromSuperview()
            self?.backgroundColor = .systemGray6
            self?.label.alpha = 1
            self?.slider.frame.origin.x =  self?.originalHorizontalPositionOfCancel ?? 0
            self?.slider.isUserInteractionEnabled = true
        }
    }
    
    func completeLoading(){
        self.loadingView?.removeFromSuperview()
        let image = UIImageView(image: .checkICon?.withTintColor(.white))
        self.slider.addSubview(image)
        self.slider.contentMode = .center
        image.tintColor = .systemGray6
        image.pinToSuperViewEdgesWithPadding(in: self.slider, padding: 15)
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {[weak self] in
            self?.completionDelegate?.confirmationCompleted()
        })
    }
    
    
}


