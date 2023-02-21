//
//  CALayer+EXT.swift
//  FC Task Manager
//
//  Created by Amr Moussa on 20/02/2023.
//

import UIKit

extension CALayer{
    func pauseAnimation() {
        if isPaused() == false {
            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }
    
    func resumeAnimation() {
        if isPaused() {
            let pausedTime = timeOffset
            speed = 1.0
            timeOffset = 0.0
            beginTime = 0.0
            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            beginTime = timeSincePause
        }
    }
    
    func isPaused() -> Bool {
        return speed == 0
    }
}
