//
//  MockMyTimerCreator.swift
//  MyBankTests
//
//  Created by DM (Personal) on 11/09/2024.
//

import MyFoundation

final class MockMyTimerCreator: MyTimerCreator {
    
    private(set) var timers = [MyTimer]()
    
    func createRepeatingTimer(duration: TimeInterval, completion: @escaping () -> Void) -> MyTimer {
        let timer = MockMyTimer()
        timers.append(timer)
        
        return timer
    }
    
}

final class MockMyTimer: MyTimer {
    private(set) var isValid = true
    func invalidate() {
        isValid = true
    }
}
