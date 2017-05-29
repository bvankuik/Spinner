//
//  VIBaseView.swift
//  Spinner
//
//  Created by Bart van Kuik on 29/05/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//


enum VIBaseViewState {
    case disappeared
    case disappearing
    case appearing
    case appeared
}



public class VIBaseView: UIView {

    internal var state: VIBaseViewState = .disappeared
    internal var disappearTask: DispatchWorkItem?
    private let animationDuration = 0.33
    private let visibleDuration = 2.5

    // MARK: - Internal functions

    internal func appear() {
        self.state = .appearing
        UIView.animate(withDuration: self.animationDuration, animations: {
            self.alpha = 1.0
        }) { (finished) in
            self.alpha = 1.0
            if finished {
                self.state = .appeared
                self.scheduleDisappear()
            }
        }
    }

    internal func scheduleDisappear() {
        self.disappearTask?.cancel()
        self.disappearTask = DispatchWorkItem {
            self.disappear()
        }
        if let task = self.disappearTask {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.visibleDuration, execute: task)
        }
    }

    internal func disappear() {
        self.state = .disappearing
        UIView.animate(withDuration: self.animationDuration, animations: {
            self.alpha = 0.0
        }, completion: { (finished) in
            if finished {
                self.alpha = 0.0
                self.state = .disappeared
                self.removeFromSuperview()
            }
        })
    }

}
