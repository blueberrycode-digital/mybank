//
//  MyTimer.swift
//  MyFoundation
//
//  Created by DM (Personal) on 11/09/2024.
//

import Foundation

public protocol MyTimer {
    var isValid: Bool { get }
    func invalidate()
}

public final class DefaultMyTimer: MyTimer {
    
    private let timer: Timer
    
    public var isValid: Bool {
        return timer.isValid
    }
    
    public func invalidate() {
        timer.invalidate()
    }
    
    public init(timer: Timer) {
        self.timer = timer
    }
    
    deinit {
        timer.invalidate()
    }
    
}

public protocol MyTimerCreator {
    func createRepeatingTimer(duration: TimeInterval, completion: @escaping () -> Void) -> MyTimer
}

public final class DefaultMyTimerCreator: MyTimerCreator {
    
    private var timers = [MyTimer]()
    
    public func createRepeatingTimer(duration: TimeInterval, completion: @escaping () -> Void) -> MyTimer {
        let timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
            completion()
        }
        let myTimer = DefaultMyTimer(timer: timer)
        timers.append(myTimer)
        
        return myTimer
    }
    
    public init() { }
    
    deinit {
        timers.forEach { $0.invalidate() }
    }
    
}
