//
//  VISpinnerView.swift
//  Spinner
//
//  Created by Bart van Kuik on 29/05/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

enum VISpinnerViewState {
    case disappeared
    case disappearing
    case appearing
    case appeared
}


public class VISpinnerView: UIView {

    static let shared = VISpinnerView()

    private let label = UILabel()
    private var constraintsInstalled = false
    private let animationDuration = 0.33
    private let visibleDuration = 2.5
    private let minimumDimension: CGFloat = 150.0
    private let margin: CGFloat = 20.0
    private var state: VISpinnerViewState = .disappeared
    private var disappearTask: DispatchWorkItem?

    // MARK: - Public functions

    public static func show(text: String, in view: UIView) {
        let toastView = VISpinnerView.shared
        if view != toastView.superview {
            toastView.removeFromSuperview()
            view.addSubview(toastView)
            let constraints = [
                toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                toastView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                toastView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1.0, constant: -10)
            ]
            view.addConstraints(constraints)
        }
        toastView.label.text = text

        switch toastView.state {
        case .disappeared:
            toastView.appear()
        case .disappearing:
            toastView.layer.removeAllAnimations()
            toastView.disappearTask?.cancel()
            toastView.alpha = 1.0
            toastView.scheduleDisappear()
        case .appearing:
            toastView.layer.removeAllAnimations()
            toastView.scheduleDisappear()
        case .appeared:
            toastView.scheduleDisappear()
        }
    }

    // MARK: - Layout

    override public func layoutSubviews() {
        if !self.constraintsInstalled {
            self.constraintsInstalled = true

            let constraints = [
                self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.minimumDimension),
                self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.minimumDimension),
                self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.margin),
                self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.margin),
                self.heightAnchor.constraint(greaterThanOrEqualTo: self.label.heightAnchor, multiplier: 1.0, constant: self.margin)
            ]
            self.addConstraints(constraints)
        }

        super.layoutSubviews()
    }

    // MARK: - Private functions

    private func appear() {
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

    private func scheduleDisappear() {
        self.disappearTask?.cancel()
        self.disappearTask = DispatchWorkItem {
            self.disappear()
        }
        if let task = self.disappearTask {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.visibleDuration, execute: task)
        }
    }

    private func disappear() {
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        self.alpha = 0.0
        self.layer.cornerRadius = 5.0
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
}
