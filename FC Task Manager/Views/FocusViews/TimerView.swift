//
//  TimerView.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 20/02/2023.
//


import UIKit



protocol TimerStatus{
    func timerFinished()
}

class TimerView: UIView {
    var timeLeft: TimeInterval = 0
    var endTime: Date?
    
    var duration:Int = 0
    
    let newTimeLabel:UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 25)
        label.text = "00:00"
        return label
    }()
    
    var loadingView =  UIView()
    var progressPath:UIBezierPath!
    var trackPath:UIBezierPath!
    var timer:Timer?
    var timerDelegate:TimerStatus?
    
    var loadingColors:(trackColor:UIColor,progressColor:UIColor,textColor:UIColor) = (trackColor:.systemBackground,progressColor:.systemOrange,textColor:.systemOrange)
    
    let progressLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(duration:Int,progressColor:UIColor = .systemOrange,trackColor:UIColor = .systemBackground,textColor:UIColor = .systemOrange) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.timeLeft = TimeInterval(duration)
        self.duration = duration
        self.loadingColors = (trackColor:trackColor,
                              progressColor:progressColor, textColor:textColor)
        configureLayout()
        
        
    }
    
    func drawAnimation(){
        configureTrackPath()
        configureProgressPath()
//        configureTimer()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        timer?.invalidate()
    }
 
    

    private func configureLayout(){
        addSubview(loadingView)
       
        loadingView.pinToSuperViewEdgesWithPadding(in: self, padding: 0)
        loadingView.backgroundColor = .clear
        addSubview(newTimeLabel)
        NSLayoutConstraint.activate([
            newTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            newTimeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            newTimeLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            newTimeLabel.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.7),
        ])
        backgroundColor = .clear
        newTimeLabel.textAlignment = .center
        newTimeLabel.textColor = loadingColors.textColor
        newTimeLabel.text = String(duration/60)
        newTimeLabel.numberOfLines = 1
        newTimeLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawAnimation()
    }
     
   
    private func configureTrackPath(){
        trackLayer.path = UIBezierPath(arcCenter:loadingView.center, radius:
                                        loadingView.frame.height/2, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        trackLayer.strokeColor = loadingColors.trackColor.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 7
        loadingView.layer.addSublayer(trackLayer)
    }
    
    private func configureProgressPath(){
        progressLayer.path = UIBezierPath(arcCenter: loadingView.center, radius:
                                            loadingView.frame.height/2, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        progressLayer.strokeColor = loadingColors.progressColor.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 7
        progressLayer.lineCap = CAShapeLayerLineCap.round


        loadingView.layer.addSublayer(progressLayer)
    }
     
     func configureTimer(){
         endTime = Date().addingTimeInterval(timeLeft)
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    @objc  func  updateTimerLabel(){
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            newTimeLabel.text  = timeLeft.time
        } else {
            newTimeLabel.text = "0".lowercased()
            newTimeLabel.textColor = .red
            timer?.invalidate()
            timerDelegate?.timerFinished()
        }
    }
    
    
    func pauseTimer(){
        guard let presentation = progressLayer.presentation() else {
            return
        }
        timer?.invalidate()
        progressLayer.strokeEnd = presentation.strokeEnd
        progressLayer.removeAnimation(forKey: "strokeEnd")
    }
    
    
    func resumeTimer(){
        if  let timer = timer , timer.isValid {return}
        
        configureTimer()
        strokeIt.fromValue = 1 -  (timeLeft/Double(duration))
        strokeIt.toValue = 1
        strokeIt.duration = timeLeft
        strokeIt.isRemovedOnCompletion = false
        progressLayer.add(strokeIt, forKey: "strokeEnd")
    }
}



