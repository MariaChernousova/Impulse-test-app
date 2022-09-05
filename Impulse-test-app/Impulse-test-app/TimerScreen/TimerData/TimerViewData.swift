//
//  TimerViewData.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 04.09.2022.
//

import Foundation

struct TimerViewData: TimerViewDataProvider {
    let buttonTitle = "Continue"
    let timerText: String
    var isButtonEnabled: Bool
    let progress: Float
    
    init(maxValue: Int, currentValue: Int, isContinueEnabled: Bool) {
        let minutes = Int(currentValue) / 60 % 60
        let seconds = Int(currentValue) % 60
        timerText = String(format:"%02i:%02i", minutes, seconds)
        isButtonEnabled = isContinueEnabled
        progress = Float(Double(currentValue) / Double(maxValue))
    }
}
