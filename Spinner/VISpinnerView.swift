//
//  VISpinnerView.swift
//  Spinner
//
//  Created by Bart van Kuik on 29/05/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//


public class VISpinnerView: VIBaseView {

    static let shared = VISpinnerView()

    private let label = UILabel()
    private let stackView = UIStackView()
    private let activityIndicatorView: UIActivityIndicatorView
    private var constraintsInstalled = false
    private let minimumDimension: CGFloat = 150.0
    private let margin: CGFloat = 20.0

    // MARK: - Public functions

    public static func show(text: String, in view: UIView) {
        let spinnerView = VISpinnerView.shared
        if view != spinnerView.superview {
            spinnerView.removeFromSuperview()
            view.addSubview(spinnerView)
            let constraints = [
                spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                spinnerView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1.0, constant: -10)
            ]
            view.addConstraints(constraints)
        }
        spinnerView.label.text = text

        switch spinnerView.state {
        case .disappeared:
            spinnerView.appear()
        case .disappearing:
            spinnerView.layer.removeAllAnimations()
            spinnerView.disappearTask?.cancel()
            spinnerView.alpha = 1.0
            spinnerView.scheduleDisappear()
        case .appearing:
            spinnerView.layer.removeAllAnimations()
            spinnerView.scheduleDisappear()
        case .appeared:
            spinnerView.scheduleDisappear()
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
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.startAnimating()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = self.margin
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(activityIndicatorView)
        stackView.addArrangedSubview(label)

        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        self.alpha = 0.0
        self.layer.cornerRadius = 5.0
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
}

