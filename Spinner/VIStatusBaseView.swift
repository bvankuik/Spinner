//
//  VIBaseView.swift
//  Spinner
//
//  Created by Bart van Kuik on 29/05/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//


enum VIStatusBaseViewState {
    case disappeared
    case disappearing
    case appearing
    case appeared
}



public class VIStatusBaseView: UIView {

    internal var state: VIStatusBaseViewState = .disappeared
    internal var disappearTask: DispatchWorkItem?
    internal let animationDuration = 0.33
    private let visibleDuration = 2.5

    // MARK: - Public functions

    public static func showBaseView(baseView: VIStatusBaseView, in containingView: UIView) {
        baseView.centerView(in: containingView)

        switch baseView.state {
        case .disappeared:
            baseView.appear()
        case .disappearing:
            baseView.layer.removeAllAnimations()
            baseView.disappearTask?.cancel()
            baseView.alpha = 1.0
            baseView.scheduleDisappear()
        case .appearing:
            baseView.layer.removeAllAnimations()
            baseView.scheduleDisappear()
        case .appeared:
            baseView.scheduleDisappear()
        }
    }

    // MARK: - Internal functions

    internal func centerView(in containingView: UIView) {
        if containingView != self.superview {
            self.removeFromSuperview()
            containingView.addSubview(self)
            let constraints = [
                self.centerXAnchor.constraint(equalTo: containingView.centerXAnchor),
                self.centerYAnchor.constraint(equalTo: containingView.centerYAnchor),
                self.widthAnchor.constraint(lessThanOrEqualTo: containingView.widthAnchor, multiplier: 1.0, constant: -10)
            ]
            containingView.addConstraints(constraints)
        }

        containingView.bringSubviewToFront(self)
    }

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

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0.0
        self.layer.cornerRadius = 5.0
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }

}
