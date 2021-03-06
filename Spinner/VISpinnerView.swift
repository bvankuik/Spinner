//
//  VISpinnerView.swift
//  Spinner
//
//  Created by Bart van Kuik on 29/05/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//


public class VISpinnerView: VIStatusBaseView {

    static let shared = VISpinnerView()

    internal let label = UILabel()
    private let stackView = UIStackView()
    private let activityIndicatorView: UIActivityIndicatorView
    private var constraintsInstalled = false
    private let minimumDimension: CGFloat = 150.0
    private let margin: CGFloat = 20.0

    // MARK: - Public functions

    public static func show(text: String, in containingView: UIView) {
        let spinnerView = VISpinnerView.shared
        spinnerView.label.text = text

        spinnerView.centerView(in: containingView)

        switch spinnerView.state {
        case .disappeared:
            spinnerView.appear()
        case .disappearing:
            spinnerView.layer.removeAllAnimations()
            spinnerView.alpha = 1.0
        case .appearing:
            break
        case .appeared:
            break
        }
    }

    public static func hide() {
        let baseView = VISpinnerView.shared

        switch baseView.state {
        case .disappeared:
            break
        case .disappearing:
            break
        case .appearing:
            baseView.disappear()
        case .appeared:
            baseView.disappear()
        }
    }

    // MARK: - Override functions

    override internal func appear() {
        self.state = .appearing
        UIView.animate(withDuration: self.animationDuration, animations: {
            self.alpha = 1.0
        }) { (finished) in
            self.alpha = 1.0
            if finished {
                self.state = .appeared
            }
        }
    }

    // MARK: - Layout

    override public func layoutSubviews() {
        if !self.constraintsInstalled {
            self.constraintsInstalled = true

            let constraints = [
                self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.margin),
                self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.margin),
                self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.margin),
                self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.margin),
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: self.minimumDimension),
                self.heightAnchor.constraint(greaterThanOrEqualToConstant: self.minimumDimension),
            ]
            self.addConstraints(constraints)
        }

        super.layoutSubviews()
    }

    // MARK: - Life cycle

    override init(frame: CGRect) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.lineBreakMode = .byTruncatingTail
        activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.startAnimating()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = self.margin
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(activityIndicatorView)
        stackView.addArrangedSubview(label)

        super.init(frame: frame)
        self.addSubview(stackView)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
}

